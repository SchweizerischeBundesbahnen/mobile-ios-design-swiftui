#!groovy

String cron_string = BRANCH_NAME == "develop" ? "@midnight" : ""

// Pipeline Config Version 0.0.6
pipeline {
    agent none
    triggers { cron(cron_string) }
    environment {
        // Credentials
        KEYCHAIN_PASSWORD = credentials('keychain-password')
        FASTLANE_PASSWORD = credentials('mwe-apple-password')

        // Apple Developer Program Team
        TEAM_PROFILE = "sbb_cargo_appstore"
        
        // Artifactory
        ARTIFACTORY_CREDENTIALS = credentials('userpass_artifactory')
        BIN_REPO_ID = "designsystem.ios"
        BIN_GROUP_ID = "ch/sbb/designsystem-swiftui"
        
        // MDM Distribution
        MOBILEIRON_CREDENTIALS = credentials('userpass_mobileiron')
        
        // Xcode
        REQUIRED_XCODE_VERSION = "~> 12.0"
        TEST_DEVICES = 'iPhone 8'
	

        // SBBCocoaPods (podspec)
        POD_REPO_NAME = "sbb-scm-kd_cp-sbbcocoapods"
        POD_SPEC_FILE = "SBBMobileDesignSystemSwiftUI.podspec.json"
        PODSPEC_RELEASE = "true"
    }
    stages {
        stage('Unit Test') {
            steps {
                node('ios') {
                    checkout scm
                    fastlane lane:'unit_test', scheme:'SBBMobileDesignSystemSwiftUIDemo'
                    archive 'build/*_reports/**/*'
                }
            }
        }
        stage('Build & Sign') {
            when {
                expression { BRANCH_NAME ==~ /(master|release\/.*)/ }
            }
            steps {
                parallel(
                    'SBB DSM': {
                        node('ios') {
                            checkout scm
                            fastlane lane:'xcframework_ios_build', scheme:'SBBMobileDesignSystemSwiftUI', repo_artifact_id:'mobiledesignsystemswiftui-ios', stash_to:'mobiledesignsystemswiftui-ios'
                        }
                    },
                    'SBB DSM Demo App (Cargo AppStore)': {
                        node('ios') {
                            checkout scm
                            fastlane lane:'appstore_build', scheme:'SBB DSM Demo App (Enterprise AppStore)', app_identifier:'ch.sbb.SBBMobileDesignSystemSwiftUIDemo', repo_artifact_id:'mobiledesignsystemswiftuidemo-ios-cargoappstore', team_profile:'sbb_cargo_appstore', stash_to:'mobiledesignsystemswiftuidemo-ios-cargoappstore'
                        }
                    },
                    'SBB DSM Demo App (Enterprise AppStore)': {
                        node('ios') {
                            checkout scm
                            fastlane lane:'enterprise_build', scheme:'SBB DSM Demo App (Enterprise AppStore)', app_identifier:'ch.sbb.DesignSystemMobileDemo', repo_artifact_id:'mobiledesignsystemswiftuidemo-ios-enterpriseappstore', team_profile:'sbb_enterprise', stash_to:'mobiledesignsystemswiftuidemo-ios-enterpriseappstore'
                        }
                    }
                )
            }
        }
        stage('Store Upload') {
            when {
                branch 'master'
            }
            steps {
                parallel(
                    'SBB DSM Demo App (Testflight - Cargo AppStore)': {
						node('ios') {
							checkout scm
							fastlane unstash_from:'mobiledesignsystemswiftuidemo-ios-cargoappstore', lane:'upload_testflight', team_profile:'sbb_cargo_appstore'
						}
                    })
                    // TODO - MobileIron Upload, once ready
                    /*'SBB DSM Demo App (MobileIron - Enterprise AppStore)': {
                        node('ios') {
                            checkout scm
                            fastlane lane:'upload_mobileiron', unstash_from:'mobiledesignsystemswiftuidemo-ios-enterpriseappstore', cleanPreviousVersions:'false'
                        }
                    }*/
            }
        }
        stage('Release Tag') {
            when {
                branch 'master'
            }
            steps {
                node('ios') {
                    checkout scm
                    fastlane lane:'release_ios', unstash_from:'mobiledesignsystemswiftui-ios'
                }
            }
        }
    }
    post { 
        failure {
            emailext subject: "Build failure: ${currentBuild.fullDisplayName}", body: "Build failure: : ${env.BUILD_URL}", recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']]
        }
    }
}
