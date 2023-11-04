
# sudo hddtemp /dev/sda
# echo
sudo hddtemp /dev/sdb
echo
sensors | sed -n 3,8p
echo
echo GPU
nvidia-smi | sed -n 9p
