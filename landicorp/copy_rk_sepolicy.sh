#! /bin/bash

base_path="rk_sepolicy"
obj_path="out/target/product/px30_ld/obj/ETC"
sub_path="system/etc/selinux"
vendor_path="vendor/etc/selinux"

echo "Starting Copy Sepolicy file:"
rm -rf $base_path 
mkdir -p $base_path
echo "1.Create rk_sepolicy directory"
mkdir -p ${base_path}/${sub_path}/
echo "2.Copy Platform Sepolicy file into rk_sepolicy directory"
cp ${obj_path}/plat_hwservice_contexts_intermediates/plat_hwservice_contexts ${base_path}/${sub_path}/
cp ${obj_path}/plat_and_mapping_sepolicy.cil.sha256_intermediates/plat_and_mapping_sepolicy.cil.sha256 ${base_path}/${sub_path}/
cp ${obj_path}/plat_property_contexts_intermediates/plat_property_contexts ${base_path}/${sub_path}/
cp ${obj_path}/plat_file_contexts_intermediates/plat_file_contexts ${base_path}/${sub_path}/
cp ${obj_path}/plat_sepolicy.cil_intermediates/plat_sepolicy.cil ${base_path}/${sub_path}/
cp ${obj_path}/plat_service_contexts_intermediates/plat_service_contexts ${base_path}/${sub_path}/
cp ${obj_path}/plat_mac_permissions.xml_intermediates/plat_mac_permissions.xml ${base_path}/${sub_path}/
cp ${obj_path}/plat_seapp_contexts_intermediates/plat_seapp_contexts ${base_path}/${sub_path}/

echo "3.Copy NonPlatform Sepolicy file into rk_sepolicy directory"
mkdir -p ${base_path}/${vendor_path}/
cp ${obj_path}/nonplat_file_contexts_intermediates/nonplat_file_contexts ${base_path}/${vendor_path}/
cp ${obj_path}/nonplat_service_contexts_intermediates/nonplat_service_contexts ${base_path}/${vendor_path}/
cp ${obj_path}/nonplat_hwservice_contexts_intermediates/nonplat_hwservice_contexts ${base_path}/${vendor_path}/
cp ${obj_path}/plat_sepolicy_vers.txt_intermediates/plat_sepolicy_vers.txt ${base_path}/${vendor_path}/
cp ${obj_path}/nonplat_mac_permissions.xml_intermediates/nonplat_mac_permissions.xml ${base_path}/${vendor_path}/
cp ${obj_path}/nonplat_mac_permissions.xml_intermediates/nonplat_mac_permissions.xml ${base_path}/${vendor_path}/
cp ${obj_path}/precompiled_sepolicy_intermediates/precompiled_sepolicy ${base_path}/${vendor_path}/
cp ${obj_path}/nonplat_property_contexts_intermediates/nonplat_property_contexts ${base_path}/${vendor_path}/
cp ${obj_path}/nonplat_property_contexts_intermediates/nonplat_property_contexts ${base_path}/${vendor_path}/
cp ${obj_path}/precompiled_sepolicy.plat_and_mapping.sha256_intermediates/precompiled_sepolicy.plat_and_mapping.sha256 ${base_path}/${vendor_path}/
cp ${obj_path}/nonplat_seapp_contexts_intermediates/nonplat_seapp_contexts ${base_path}/${vendor_path}/
cp ${obj_path}/vndservice_contexts_intermediates/vndservice_contexts ${base_path}/${vendor_path}/
cp ${obj_path}/nonplat_sepolicy.cil_intermediates/nonplat_sepolicy.cil ${base_path}/${vendor_path}/










