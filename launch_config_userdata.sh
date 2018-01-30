Content-Type: multipart/mixed; boundary="==BOUNDARY=="
MIME-Version: 1.0
--==BOUNDARY==
Content-Type: text/cloud-boothook; charset="us-ascii"
# Set Docker daemon options
cloud-init-per once docker_options echo 'OPTIONS="${OPTIONS} --storage-opt dm.basesize=100G"' >> /etc/sysconfig/docker
--==BOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"
#!/bin/bash
# Set the ECS agent configuration options
cat <<'EOF' >> /etc/ecs/ecs.config
ECS_CLUSTER=platformnonprod
ECS_ENGINE_TASK_CLEANUP_WAIT_DURATION=15m
ECS_IMAGE_CLEANUP_INTERVAL=10m
EOF
sysctl -w vm.max_map_count=262144
mkdir -p /usr/share/elasticsearch/data/
chown -R 1000.1000 /usr/share/elasticsearch/data/
yum install -y nfs-utils
mkdir -p /efs
chown ec2-user:ec2-user /efs
echo "fs-xxxxxxxx.efs.us-west-2.amazonaws.com:/ /efs nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 0 0" >> /etc/fstab
mount -a -t nfs4
--==BOUNDARY==--