
TARGET=$1

if [[ "${TARGET}" == "" || ( "${TARGET}" != "test" && "${TARGET}" != "prod" ) ]]; then
    echo "Missing target env, must be 'prod' or 'test'"
    exit 1
fi

cd ~/deploy-api-${TARGET}
git config user.email "me@youzd.fr"
git config user.name "Youzd ci"
git rm -r *

find ~/repo \( -path ~/repo/packages/client -o -path ~/repo/node_modules -o -path ~/repo/packages/admin -o -path ~/repo/packages/common -o -path ~/repo/packages/sandbox \) -prune -false -o -name package.json -print | while read FILE
do
    DESTPATH=`dirname ${FILE} | sed "s/repo/deploy-api-${TARGET}/"`
    DEST=`echo ${FILE} | sed "s/repo/deploy-api-${TARGET}/"`
    echo "Create ${DESTPATH} and copy ${FILE}"
    mkdir -p ${DESTPATH}
    cp ${FILE} ${DEST}
done

find ~/repo \( -path ~/repo/packages/client -o -path ~/repo/node_modules -o -path ~/repo/packages/admin -o -path ~/repo/packages/common -o -path ~/repo/packages/sandbox \) -prune -false -o -name build -print | while read FILE
do
    DEST=`echo ${FILE} | sed "s/repo/deploy-api-${TARGET}/"`
    echo "Copy ${FILE}"
    cp -r ${FILE} ${DEST}
done

cp ~/repo/yarn.lock ~/deploy-api-${TARGET}
cp -r ~/repo/test-keys ~/deploy-api-${TARGET}
cp -r ~/repo/packages/tech/migrations ~/deploy-api-${TARGET}/packages/tech
cp -r ~/repo/packages/billing/assets ~/deploy-api-${TARGET}/packages/api/src/billing
cp ~/repo/packages/tech/database.json ~/deploy-api-${TARGET}/packages/tech/database.json

cd ~/repo
MESSAGE=`git log --format=oneline --no-decorate --abbrev-commit -n 1`

cd ~/deploy-api-${TARGET}
git add .
NB_CHANGES=`git status -s | wc -l`
if [ ${NB_CHANGES} -gt 0 ]; then
    git commit -m "${MESSAGE}"
fi

git clone -o clever git+ssh://git@push-par-clevercloud-customers.services.clever-cloud.com/app_213456743246.git --depth=1 ~/test-api
git clone -o clever git+ssh://git@push-par-clevercloud-customers.services.clever-cloud.com/app_342567834567.git --depth=1 ~/prod-api
(cd ~/prod-api && git rm -r *)
cp -r ~/test-api/* ~/prod-api

cd ~/prod-api
NB_CHANGES=$(git status -s | wc -l) && if [ ! "${NB_CHANGES}" -gt 0 ]; then exit 0;fi;
git add .
MESSAGE=$(git log --format=oneline --no-decorate --abbrev-commit -n 1)
git commit -m "${MESSAGE}"
git push clever master
