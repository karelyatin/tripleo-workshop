# Ceph lab

## Part 1

1. Install ceph-ansible on the undercloud
```
yum install ceph-ansible
```

2. Put the following files in stack's home directory on your undercloud
   - [ceph.yaml](ceph.yaml)
   - [deploy-ceph.sh](deploy-ceph.sh)

3. Start the deplolyment
```
bash deploy-ceph.sh
```

4. Become root on the undercloud and execute the following:
```
sudo tail -f /var/log/mistral/ceph-install-workflow.log
```
The above file will not exist until Step 2 of the deployment

## Part 2

1. Read [deploy-ceph.sh](deploy-ceph.sh)
   - How does it differ from the overcloud-deploy.sh created by quickstart?

2. Read [ceph.yaml](ceph.yaml)
   - Which directive writes configuratoin options directly to /etc/ceph.conf?
   - Which directive controls the memory and CPU allocated to each OSD container?
   - Which directive defines the disks which will host OSDs?
   - Which directive defines the OSD jounral disks?

## Part 3

1. Execute the following on the undercloud as root and take note of
the last directory returned by the command; it will be the newest directory.
```
ls -lhtr /tmp/
```

2. Change into the directory returned from the previous command. E.g.
```
cd /tmp/ansible-mistral-actionVoB_Q8
```
3. Explore the directory
   - What is in inventory.yaml?
   - How was the playbook executed?

The above directory is created by Mistral when it runs ceph-ansible. The same Mistral workflow will also delete it unless `CephAnsiblePlaybookVerbosity` has been set to a value between 1 and 5 as done in [ceph.yaml](ceph.yaml).

## Part 4

Only do this if your deployment is finished.

1. Validate the overcloud as described in the last step of the oooq lab ([../oooq/oooq-lab.txt](../oooq/oooq-lab.txt)).

2. SSH into an overcloud controller and run the following as root to answer their respective questions
   - `docker ps | grep ceph` which containers are running?
   - `ceph -s`
	 - Are the monitors in quorum?
	 - What is the cluster health?
	 - How many OSDs are up?
   - `ceph df`
     - How much raw space does the cluster have?
	 - How many pools are there?
   - `ip a` and then `cat /etc/ceph/ceph.conf`
     - What is the IP range of the of cluster network (the network used to rebalance data)?
	 - What are the IPs of the Ceph mons (the network used to access Ceph)?
	 - Why might we wish to isolate the network used to rebalance data?
     - How do these networks map to the `network-environment.yaml` on the undercloud?

3. SSH into a ceph-storage node and run the following as root to answer their respective questions
	- `docker ps | grep ceph` which containers are running and how are they named? Do the names align with each OSDs disk?
	- `lsblk`
	  - How many partitions do /dev/vdb and /dev/vdc have and how big are they?
	  - How many partitions does /dev/vdd have and how big are they?
	  - Can you explain the difference?

4. SSH back into an overcloud controller after the validation and re-run `ceph df` to see if the number of objects in the pools have changed.
