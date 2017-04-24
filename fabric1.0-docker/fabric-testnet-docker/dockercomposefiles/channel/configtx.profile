---
################################################################################
#
#   Profile - meant to be used with docker-2orgs-2peerseach-e2e.yml
#
#   - Different configuration profiles may be encoded here to be specified
#   as parameters to the configtxgen tool
#
################################################################################
Profiles:

    TwoOrgs:
        Orderer:
            <<: *OrdererDefaults
            Organizations:
                - *OrdererOrg
        Application: 
            <<: *ApplicationDefaults
            Organizations:
                - *Org0
                - *Org1

################################################################################
#
#   Section: Organizations
#
#   - This section defines the different organizational identities which will
#   be referenced later in the configuration.
#
################################################################################
Organizations:

    # SampleOrg defines an MSP using the sampleconfig.  It should never be used
    # in production but may be used as a template for other definitions
    - &OrdererOrg
        # DefaultOrg defines the organization which is used in the sampleconfig
        # of the fabric.git development environment
        Name: OrdererMSP

        # ID to load the MSP definition as
        ID: OrdererMSP

        # MSPDir is the filesystem path which contains the MSP configuration
        #########################################################################
        # FIXME: this path needs to be fixed to point to the actual location of #
        # the project 'fabric-sdk-node' in the file system                      #
        #########################################################################
        MSPDir: crypto-config/ordererOrganizations/ordererOrg1/msp

        # BCCSP (Blockchain crypto provider): Select which crypto implementation or
        # library to use
        BCCSP:
            Default: SW
            SW:
                Hash: SHA2
                Security: 256
                # Location of Key Store. If this is unset, a location will 
                # be chosen using 'MSPDir'/keystore
                FileKeyStore: 
                    KeyStore: 
                
    - &Org0
        # DefaultOrg defines the organization which is used in the sampleconfig
        # of the fabric.git development environment
        Name: Org1MSP

        # ID to load the MSP definition as
        ID: Org1MSP

        # MSPDir is the filesystem path which contains the MSP configuration
        #########################################################################
        # FIXME: this path needs to be fixed to point to the actual location of #
        # the project 'fabric-sdk-node' in the file system                      #
        #########################################################################
        MSPDir: crypto-config/peerOrganizations/peerOrg1/msp/

        # BCCSP (Blockchain crypto provider): Select which crypto implementation or
        # library to use
        BCCSP:
            Default: SW
            SW:
                Hash: SHA2
                Security: 256
                # Location of Key Store. If this is unset, a location will 
                # be chosen using 'MSPDir'/keystore
                FileKeyStore: 
                    KeyStore: 
                
        AnchorPeers:
            # AnchorPeers defines the location of peers which can be used
            # for cross org gossip communication.  Note, this value is only
            # encoded in the genesis block in the Application section context
            - Host: peer0
              Port: 7051
            - Host: peer1
              Port: 7056

    - &Org1
        # DefaultOrg defines the organization which is used in the sampleconfig
        # of the fabric.git development environment
        Name: Org2MSP

        # ID to load the MSP definition as
        ID: Org2MSP

        # MSPDir is the filesystem path which contains the MSP configuration
        #########################################################################
        # FIXME: this path needs to be fixed to point to the actual location of #
        # the project 'fabric-sdk-node' in the file system                      #
        #########################################################################
        MSPDir: crypto-config/peerOrganizations/peerOrg2/msp/

        # BCCSP (Blockchain crypto provider): Select which crypto implementation or
        # library to use
        BCCSP:
            Default: SW
            SW:
                Hash: SHA2
                Security: 256
                # Location of Key Store. If this is unset, a location will 
                # be chosen using 'MSPDir'/keystore
                FileKeyStore: 
                    KeyStore: 
                
        AnchorPeers:
            # AnchorPeers defines the location of peers which can be used
            # for cross org gossip communication.  Note, this value is only
            # encoded in the genesis block in the Application section context
            - Host: peer2
              Port: 8051
            - Host: peer3
              Port: 8056

################################################################################
#
#   SECTION: Orderer
#
#   - This section defines the values to encode into a config transaction or
#   genesis block for orderer related parameters
#
################################################################################
Orderer: &OrdererDefaults

    # Orderer Type: The orderer implementation to start
    # Available types are "solo" and "kafka"
    OrdererType: solo

    Addresses:
        - orderer0:7050

    # Batch Timeout: The amount of time to wait before creating a batch
    BatchTimeout: 10s

    # Batch Size: Controls the number of messages batched into a block
    BatchSize:

        # Max Message Count: The maximum number of messages to permit in a batch
        MaxMessageCount: 10

        # Absolute Max Bytes: The absolute maximum number of bytes allowed for
        # the serialized messages in a batch.
        AbsoluteMaxBytes: 99 MB

        # Preferred Max Bytes: The preferred maximum number of bytes allowed for
        # the serialized messages in a batch. A message larger than the preferred
        # max bytes will result in a batch larger than preferred max bytes.
        PreferredMaxBytes: 512 KB

    Kafka:
        # Brokers: A list of Kafka brokers to which the orderer connects
        # NOTE: Use IP:port notation
        Brokers:
            - orderer0:9092

    # Organizations is the list of orgs which are defined as participants on
    # the orderer side of the network
    Organizations:

################################################################################
#
#   SECTION: Application
#
#   - This section defines the values to encode into a config transaction or
#   genesis block for application related parameters
#
################################################################################
Application: &ApplicationDefaults

    # Organizations is the list of orgs which are defined as participants on
    # the application side of the network
    Organizations:
