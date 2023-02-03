#!/bin/bashqq

get_metadata_session_as_csv() {
echo " I AM IN copy_masks_data "
# rm -r /ZIPFILEDIR/*
sessionID=${1}

python3 -c "
import sys
sys.path.append('/software');
from download_with_session_ID import *;
call_get_metadata_session_as_csv()" ${sessionID}    ### ${infarctfile_present}  ##$static_template_image $new_image $backslicenumber #$single_slice_filename


}
get_metadata_scanresources_as_csv() {
URI=${1}
resource_dir=${2}
python3 -c "
import sys
sys.path.append('/software');
from download_with_session_ID import *;
call_get_resourcefiles_metadata_as_csv()" ${URI}  ${resource_dir}  #${resource_dirname}  ${output_dirname}    ### ${infarctfile_present}  ##$static_template_image $new_image $backslicenumber #$single_slice_filename


}
downloadresourcefilewithuri(){


url=${1} #sys.argv[1]
filename=${2}
dir_to_save=${3} #sys.argv[2]
python3 -c "
import sys
sys.path.append('/software');
from download_with_session_ID import *;
call_downloadresourcefilewithuri_name_py()" ${url} ${filename} ${dir_to_save}  #${resource_dirname}  ${output_dirname}    ### ${infarctfile_present}  ##$static_template_image $new_image $backslicenumber #$single_slice_filename


}
## download list of sessions
sessionId=SNIPR_E03517
get_metadata_session_as_csv $sessionId
################### FOR DICOM ###############################
######## LEARN HOW TO READ DATA FROM CSV with BASH
URI='/data/experiments/SNIPR_E03517/scans/2'
resource_dir='DICOM'
get_metadata_scanresources_as_csv ${URI} ${resource_dir}
FILE_URI='/data/experiments/SNIPR_E03517/scans/2/resources/69957/files/1.2.840.113654.2.45.6242.41786130236813614531978884608083678057-2-40-19uug1m.dcm' #,DICOM,1.2.840.113654.2.45.6242.41786130236813614531978884608083678057-2-40-19uug1m.dcm'
filename=$(basename ${FILE_URI})
dicom_dir=${sessionId}_2_DICOM
mkdir $dicom_dir
dir_to_save=${dicom_dir}
echo '$filename'::$filename
downloadresourcefilewithuri ${FILE_URI} ${filename} ${dir_to_save}
##################### FOR NIFTI #####################################
URI='/data/experiments/SNIPR_E03517/scans/2'
resource_dir='NIFTI'
get_metadata_scanresources_as_csv ${URI} ${resource_dir}
FILE_URI='/data/experiments/SNIPR_E03517/scans/2/resources/110266/files/BJH_001_12112019_2320_2.nii'
filename=$(basename ${FILE_URI})
mkdir NIFTIDIR
dir_to_save='NIFTIDIR'
echo '$filename'::$filename
downloadresourcefilewithuri ${FILE_URI} ${filename} ${dir_to_save}
