# replace ancient system libstdc++, plug ours in.
# This is a workaround for some recipes that do not respect LIBRARY_PATH.

libraries=(libstdc++.so.6.0.21 libstdc++.so.6 libstdc++.so
           libgcc_s.so.1 libgcc_s.so
           libgomp.so.1.0.0 libgomp.so.1 libgomp.so
           libgfortran.so.3.0.0 libgfortran.so.3 libgfortran.so
           libquadmath.so.0.0.0 libquadmath.so.0 libquadmath.so)
folders=(lib lib64)

for folder in "${folders[@]}"
do
    for library in "${libraries[@]}"
    do
        rm -f /usr/$folder/$library
        ln -s /usr/local/$folder/$library /usr/$folder/$library
    done
done
