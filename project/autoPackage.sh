function error_exit {
	echo "$1"
  	say "$1"
  	exit 1
}

function say_and_echo {
	echo "$1"
	say "$1"
}

while getopts b:e: OPT; do
  case ${OPT} in
    b) target_branch=${OPTARG}
       ;;
    e) enviroment=${OPTARG}
       ;;
    \?)
       exit 1
  esac
done

say_and_echo "注意，iOS打包开始，请避免占用大量CPU"

say_and_echo "开始执行git命令，拉取最新code"
git clean -df
git reset --hard

if [ X${target_branch} != "X" ]
then
say_and_echo "切换至分支${target_branch}"
git checkout ${target_branch}
else
current_branch=`git symbolic-ref --short -q HEAD`
say_and_echo "当前分支$current_branch"
fi

git pull -p 
echo "**********************最新1条提交记录************************"
output=`git log -1`
echo -e ${output} 
# pod install

# echo '**********************删除build文件夹下内容*******************'
# mkdir -p build
# rm -rf build/archive.xcarchive build/ipa-*
workspace_list=`ls | grep .xcworkspace`
workspace_name=${workspace_list%%.*}

say_and_echo '开始clean'
say_and_echo "开始清理缓存文件"
echo "clean all the DerivedData in `pwd $HOME/Library/Developer/Xcode/`"
rm -rf $HOME/Library/Developer/Xcode/DerivedData
rm -rf ./build
xcodebuild clean || error_exit "Clean失败，退出当前脚本"

say_and_echo '开始Archive工程'

xcodebuild archive \
  -workspace ${workspace_name}.xcworkspace \
  -scheme ${workspace_name} \
  -configuration Release \
  -archivePath ./build/archive.xcarchive || error_exit "Archive失败，退出当前脚本"

say_and_echo '开始导出I P A'

xcodebuild -exportArchive \
    -archivePath ./build/archive.xcarchive \
    -exportPath ./build/ipa-ad-hoc \
    -exportOptionsPlist ./ExportOptions/ad-hoc.plist \
    -allowProvisioningUpdates || error_exit "导出失败，退出当前脚本"

say_and_echo 'iOS打包成功，欢迎食用'

