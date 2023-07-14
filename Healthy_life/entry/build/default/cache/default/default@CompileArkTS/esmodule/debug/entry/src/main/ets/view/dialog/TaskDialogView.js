/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { TargetSettingDialog, RemindTimeDialog, FrequencyDialog } from '@bundle:com.example.healthy_life/entry/ets/view/dialog/TaskSettingDialog';
import { BroadCastType } from '@bundle:com.example.healthy_life/entry/ets/common/utils/BroadCast';
import Logger from '@bundle:com.example.healthy_life/entry/ets/common/utils/Logger';
import { ZERO, MINUS_20 } from '@bundle:com.example.healthy_life/entry/ets/common/constants/CommonConstants';
export class TaskDialogView extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__isShow = new ObservedPropertySimplePU(false, this, "isShow");
        this.__broadCast = this.initializeConsume("broadCast", "broadCast");
        this.targetSettingDialog = new CustomDialogController({
            builder: () => {
                let jsDialog = new TargetSettingDialog(this, {});
                jsDialog.setController(this.
                // target setting dialog
                targetSettingDialog);
                ViewPU.create(jsDialog);
            },
            autoCancel: true,
            alignment: DialogAlignment.Bottom,
            offset: { dx: ZERO, dy: MINUS_20 }
        }, this);
        this.RemindTimeDialogController = new CustomDialogController({
            builder: () => {
                let jsDialog = new RemindTimeDialog(this, {});
                jsDialog.setController(this.
                // remind time dialog
                RemindTimeDialogController);
                ViewPU.create(jsDialog);
            },
            autoCancel: true,
            alignment: DialogAlignment.Bottom,
            offset: { dx: ZERO, dy: MINUS_20 }
        }, this);
        this.FrequencyDialogController = new CustomDialogController({
            builder: () => {
                let jsDialog = new FrequencyDialog(this, {});
                jsDialog.setController(this.
                // frequency dialog
                FrequencyDialogController);
                ViewPU.create(jsDialog);
            },
            autoCancel: true,
            alignment: DialogAlignment.Bottom,
            offset: { dx: ZERO, dy: MINUS_20 }
        }, this);
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.isShow !== undefined) {
            this.isShow = params.isShow;
        }
        if (params.targetSettingDialog !== undefined) {
            this.targetSettingDialog = params.targetSettingDialog;
        }
        if (params.RemindTimeDialogController !== undefined) {
            this.RemindTimeDialogController = params.RemindTimeDialogController;
        }
        if (params.FrequencyDialogController !== undefined) {
            this.FrequencyDialogController = params.FrequencyDialogController;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__isShow.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__isShow.aboutToBeDeleted();
        this.__broadCast.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get isShow() {
        return this.__isShow.get();
    }
    set isShow(newValue) {
        this.__isShow.set(newValue);
    }
    get broadCast() {
        return this.__broadCast.get();
    }
    set broadCast(newValue) {
        this.__broadCast.set(newValue);
    }
    aboutToAppear() {
        Logger.debug('CustomDialogView', 'aboutToAppear');
        // target setting dialog
        this.broadCast.on(BroadCastType.SHOW_TARGET_SETTING_DIALOG, () => {
            this.targetSettingDialog.open();
        });
        // remind time dialog
        this.broadCast.on(BroadCastType.SHOW_REMIND_TIME_DIALOG, () => {
            this.RemindTimeDialogController.open();
        });
        // frequency dialog
        this.broadCast.on(BroadCastType.SHOW_FREQUENCY_DIALOG, () => {
            this.FrequencyDialogController.open();
        });
    }
    aboutToDisappear() {
        Logger.debug('CustomDialogView', 'aboutToDisappear');
    }
    initialRender() {
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=TaskDialogView.js.map