# Clear cache
sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'

--kubelet-arg=image-gc-high-threshold=85 --kubelet-arg=image-gc-low-threshold=80