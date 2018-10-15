# ec2-metadata-extractor
Shell scripts to walk the metadata tree exposed to EC2 instances.

# How does it work?
As long as `wget` is available the script will be able to query the local metadata url for EC2 instances and iterate over each entry. If the entry is a 'subdirectory', the script will recursively iterate until it extracts each document.

# How to use
- Copy the script to your ec2 instance (or docker container running on an EC2 instance)
- Ensure it is marked as executable (`chmod +x eme.sh`)
- Execute the script (optionally passing in the `-noformat` flag if you don't want bolded headers)

You will see an enumerated list of ec2 meta data for your instance.

Sample output (your output will vary, especially if you have ec2 user-data!):

```
$ ./eme.sh

http://169.254.169.254/latest/meta-data/ami-id:
ami-6d1c2008


http://169.254.169.254/latest/meta-data/ami-launch-index:
0


http://169.254.169.254/latest/meta-data/ami-manifest-path:
(unknown)


http://169.254.169.254/latest/meta-data/block-device-mapping/ami:
/dev/sda1


http://169.254.169.254/latest/meta-data/block-device-mapping/root:
/dev/sda1


http://169.254.169.254/latest/meta-data/events/maintenance/history:
[]


http://169.254.169.254/latest/meta-data/events/maintenance/scheduled:
[]


http://169.254.169.254/latest/meta-data/hostname:
ip-10-0-0-14.ec2.internal


http://169.254.169.254/latest/meta-data/instance-action:
none


http://169.254.169.254/latest/meta-data/instance-id:
i-0a51ffeaca56e2a11


http://169.254.169.254/latest/meta-data/instance-type:
t2.micro


http://169.254.169.254/latest/meta-data/local-hostname:
ip-10-0-0-14.ec2.internal


http://169.254.169.254/latest/meta-data/local-ipv4:
10.0.0.14


http://169.254.169.254/latest/meta-data/mac:
01:2d:8e:ac:1c:76


http://169.254.169.254/latest/meta-data/metrics/vhostmd:
<?xml version="1.0" encoding="UTF-8"?>


http://169.254.169.254/latest/meta-data/network/interfaces/macs/01:2d:8e:ac:1c:76/device-number:
0


http://169.254.169.254/latest/meta-data/network/interfaces/macs/01:2d:8e:ac:1c:76/interface-id:
eni-62064135


http://169.254.169.254/latest/meta-data/network/interfaces/macs/01:2d:8e:ac:1c:76/ipv4-associations/34.122.12.12:
10.0.0.14

http://169.254.169.254/latest/meta-data/network/interfaces/macs/01:2d:8e:ac:1c:76/security-group-ids:
sg-13abcde4
sg-21cafff1
sg-43a9ce78


http://169.254.169.254/latest/meta-data/network/interfaces/macs/01:2d:8e:ac:1c:76/security-groups:
admin-inbound
ssh-from-specific
server-inbound


http://169.254.169.254/latest/meta-data/network/interfaces/macs/01:2d:8e:ac:1c:76/subnet-id:
subnet-52173214


http://169.254.169.254/latest/dynamic/instance-identity/signature:
dwBwBbj.../Eo=


http://169.254.169.254/latest/dynamic/instance-identity/document:
{
  "privateIp" : "10.0.0.14",
  "marketplaceProductCodes" : [ "aw1ebgyg9e5c1q413zgy4pe7e" ],
  "devpayProductCodes" : null,
  "version" : "2018-03-30",
  "instanceId" : "i-1b41c81bbfaa33181",
  "billingProducts" : null,
  "instanceType" : "t2.micro",
  "availabilityZone" : "us-east-1a",
  "kernelId" : null,
  "ramdiskId" : null,
  "accountId" : "123456789123",
  "architecture" : "x86_64",
  "imageId" : "ami-6d1c2008",
  "pendingTime" : "2019-07-16T03:56:45Z",
  "region" : "us-east-1"
}

```
