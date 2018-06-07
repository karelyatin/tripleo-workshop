#!/bin/bash

set -euxo pipefail
cd $HOME

git clone -b stable/pike https://git.openstack.org/openstack/tripleo-heat-templates tht-pike

echo > basic-deployment.yaml 'resource_registry:
  OS::TripleO::Services::Ipsec: OS::Heat::None
  OS::TripleO::Services::OsloMessagingRpc: OS::Heat::None
  OS::TripleO::Services::OsloMessagingNotify: OS::Heat::None

parameter_defaults:
  DnsServers: ["192.168.23.1"]

  ControllerImage: overcloud-full-pike
  controllerImage: overcloud-full-pike
  NovaImage: overcloud-full-pike
  ComputeImage: overcloud-full-pike
  ControllerServices:
    - OS::TripleO::Services::CACerts
    - OS::TripleO::Services::Clustercheck
    - OS::TripleO::Services::Docker
    - OS::TripleO::Services::GlanceApi
    - OS::TripleO::Services::HAproxy
    - OS::TripleO::Services::Ipsec
    - OS::TripleO::Services::Iscsid
    - OS::TripleO::Services::Keepalived
    - OS::TripleO::Services::Kernel
    - OS::TripleO::Services::Keystone
    - OS::TripleO::Services::Memcached
    - OS::TripleO::Services::MySQL
    - OS::TripleO::Services::MySQLClient
    - OS::TripleO::Services::NeutronCorePlugin
    - OS::TripleO::Services::NeutronApi
    - OS::TripleO::Services::NeutronDhcpAgent
    - OS::TripleO::Services::NeutronL3Agent
    - OS::TripleO::Services::NeutronMetadataAgent
    - OS::TripleO::Services::NeutronOvsAgent
    - OS::TripleO::Services::NovaApi
    - OS::TripleO::Services::NovaConductor
    - OS::TripleO::Services::NovaMetadata
    - OS::TripleO::Services::NovaPlacement
    - OS::TripleO::Services::NovaScheduler
    - OS::TripleO::Services::Ntp
    - OS::TripleO::Services::RabbitMQ
    - OS::TripleO::Services::Pacemaker
    - OS::TripleO::Services::Sshd
    - OS::TripleO::Services::SwiftProxy
    - OS::TripleO::Services::SwiftDispersion
    - OS::TripleO::Services::SwiftRingBuilder
    - OS::TripleO::Services::SwiftStorage
    - OS::TripleO::Services::Timezone
    - OS::TripleO::Services::TripleoFirewall
    - OS::TripleO::Services::TripleoPackages
  ComputeServices:
    - OS::TripleO::Services::CACerts
    - OS::TripleO::Services::ComputeNeutronCorePlugin
    - OS::TripleO::Services::ComputeNeutronOvsAgent
    - OS::TripleO::Services::Docker
    - OS::TripleO::Services::Ipsec
    - OS::TripleO::Services::Iscsid
    - OS::TripleO::Services::Kernel
    - OS::TripleO::Services::MySQLClient
    - OS::TripleO::Services::NovaCompute
    - OS::TripleO::Services::NovaLibvirt
    - OS::TripleO::Services::NovaMigrationTarget
    - OS::TripleO::Services::Ntp
    - OS::TripleO::Services::Sshd
    - OS::TripleO::Services::Timezone
    - OS::TripleO::Services::TripleoFirewall
    - OS::TripleO::Services::TripleoPackages
'
