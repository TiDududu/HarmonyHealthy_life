import router from '@ohos:router';
import data_preferences from '@ohos:data.preferences';
import Logger from '@bundle:com.example.healthy_life/entry/ets/common/utils/Logger';
import * as commonConst from '@bundle:com.example.healthy_life/entry/ets/common/constants/CommonConstants';
import UserPrivacyDialog from '@bundle:com.example.healthy_life/entry/ets/view/dialog/UserPrivacyDialog';
// app preferences name
const H_STORE = 'healthAppStore';
const IS_PRIVACY = 'isPrivacy';
class SplashIndex extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.context = getContext(this);
        this.dialogController = new CustomDialogController({
            builder: () => {
                let jsDialog = new UserPrivacyDialog(this, {
                    cancel: this.exitApp.bind(this),
                    confirm: this.onConfirm.bind(this)
                });
                jsDialog.setController(this.dialogController);
                ViewPU.create(jsDialog);
            },
            cancel: this.exitApp.bind(this),
            autoCancel: false,
            alignment: DialogAlignment.Bottom,
            offset: { dx: 0, dy: commonConst.OFFSET_24 }
        }, this);
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.context !== undefined) {
            this.context = params.context;
        }
        if (params.dialogController !== undefined) {
            this.dialogController = params.dialogController;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
    }
    aboutToBeDeleted() {
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    onConfirm() {
        let preferences = data_preferences.getPreferences(this.context, H_STORE);
        preferences.then((res) => {
            res.put(IS_PRIVACY, true).then(() => {
                res.flush();
                Logger.info('SplashPage', 'isPrivacy is put success');
            }).catch((err) => {
                Logger.info('SplashPage', 'isPrivacy put failed. Cause:' + err);
            });
        });
        this.jumpAdPage();
    }
    exitApp() {
        this.context.terminateSelf();
    }
    jumpAdPage() {
        setTimeout(() => {
            router.replaceUrl({ url: 'pages/AdvertisingPage' });
        }, commonConst.LAUNCHER_DELAY_TIME);
    }
    aboutToAppear() {
        let preferences = data_preferences.getPreferences(this.context, H_STORE);
        preferences.then((res) => {
            res.get(IS_PRIVACY, false).then((isPrivate) => {
                if (isPrivate === true) {
                    this.jumpAdPage();
                }
                else {
                    this.dialogController.open();
                }
            });
        });
    }
    aboutToDisappear() {
        clearTimeout();
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.width('100%');
            Column.height('100%');
            Column.backgroundImagePosition({ x: 0, y: 0 });
            Column.backgroundImage({ "id": 16777379, "type": 20000, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Column.backgroundImageSize({ width: '100%', height: '100%' });
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create({ "id": 16777394, "type": 20000, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Image.width({ "id": 16777302, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Image.aspectRatio(1);
            Image.margin({ top: { "id": 16777302, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" } });
            if (!isInitialRender) {
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create({ "id": 16777219, "type": 10003, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.fontFamily({ "id": 16777223, "type": 10003, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.fontSize({ "id": 16777310, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.fontColor({ "id": 16777287, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.fontWeight(commonConst.FONT_WEIGHT_700);
            Text.letterSpacing(commonConst.LETTER_1);
            Text.margin({
                top: { "id": 16777307, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" },
                bottom: { "id": 16777330, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" }
            });
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create({ "id": 16777218, "type": 10003, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.fontFamily({ "id": 16777222, "type": 10003, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.fontColor({ "id": 16777287, "type": 10001, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            Text.fontWeight(commonConst.FONT_WEIGHT_400);
            Text.letterSpacing(commonConst.LETTER_34);
            Text.opacity(commonConst.OPACITY_6);
            Text.fontSize({ "id": 16777305, "type": 10002, params: [], "bundleName": "com.example.healthy_life", "moduleName": "entry" });
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
ViewStackProcessor.StartGetAccessRecordingFor(ViewStackProcessor.AllocateNewElmetIdForNextComponent());
loadDocument(new SplashIndex(undefined, {}));
ViewStackProcessor.StopGetAccessRecording();
//# sourceMappingURL=SplashPage.js.map