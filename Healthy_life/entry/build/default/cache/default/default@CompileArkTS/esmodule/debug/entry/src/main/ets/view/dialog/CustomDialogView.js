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
import { AchievementDialog } from '@bundle:com.example.healthy_life/entry/ets/view/dialog/AchievementDialog';
import { TaskDetailDialog } from '@bundle:com.example.healthy_life/entry/ets/view/dialog/TaskDetailDialog';
import { BroadCastType } from '@bundle:com.example.healthy_life/entry/ets/common/utils/BroadCast';
import { TaskItem } from '@bundle:com.example.healthy_life/entry/ets/model/TaskInitList';
import Logger from '@bundle:com.example.healthy_life/entry/ets/common/utils/Logger';
export class CustomDialogView extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__isShow = new ObservedPropertySimplePU(false, this, "isShow");
        this.__achievementLevel = new ObservedPropertySimplePU(0, this, "achievementLevel");
        this.addProvidedVar("achievementLevel", this.__achievementLevel);
        this.__broadCast = this.initializeConsume("broadCast", "broadCast");
        this.__currentTask = new ObservedPropertyObjectPU(TaskItem, this, "currentTask");
        this.addProvidedVar("currentTask", this.__currentTask);
        this.__dialogCallBack = new ObservedPropertyObjectPU({ confirmCallback: null, cancelCallback: null }, this, "dialogCallBack");
        this.addProvidedVar("dialogCallBack", this.__dialogCallBack);
        this.achievementDialog = new CustomDialogController({
            builder: () => {
                let jsDialog = new AchievementDialog(this, {});
                jsDialog.setController(this.
                // achievement dialog
                achievementDialog);
                ViewPU.create(jsDialog);
            },
            autoCancel: true,
            customStyle: true
        }, this);
        this.taskDialog = new CustomDialogController({
            builder: () => {
                let jsDialog = new TaskDetailDialog(this, {});
                jsDialog.setController(this.
                // task clock dialog
                taskDialog);
                ViewPU.create(jsDialog);
            },
            autoCancel: true,
            customStyle: true
        }, this);
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.isShow !== undefined) {
            this.isShow = params.isShow;
        }
        if (params.achievementLevel !== undefined) {
            this.achievementLevel = params.achievementLevel;
        }
        if (params.currentTask !== undefined) {
            this.currentTask = params.currentTask;
        }
        if (params.dialogCallBack !== undefined) {
            this.dialogCallBack = params.dialogCallBack;
        }
        if (params.achievementDialog !== undefined) {
            this.achievementDialog = params.achievementDialog;
        }
        if (params.taskDialog !== undefined) {
            this.taskDialog = params.taskDialog;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__isShow.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__isShow.aboutToBeDeleted();
        this.__achievementLevel.aboutToBeDeleted();
        this.__broadCast.aboutToBeDeleted();
        this.__currentTask.aboutToBeDeleted();
        this.__dialogCallBack.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get isShow() {
        return this.__isShow.get();
    }
    set isShow(newValue) {
        this.__isShow.set(newValue);
    }
    get achievementLevel() {
        return this.__achievementLevel.get();
    }
    set achievementLevel(newValue) {
        this.__achievementLevel.set(newValue);
    }
    get broadCast() {
        return this.__broadCast.get();
    }
    set broadCast(newValue) {
        this.__broadCast.set(newValue);
    }
    get currentTask() {
        return this.__currentTask.get();
    }
    set currentTask(newValue) {
        this.__currentTask.set(newValue);
    }
    get dialogCallBack() {
        return this.__dialogCallBack.get();
    }
    set dialogCallBack(newValue) {
        this.__dialogCallBack.set(newValue);
    }
    aboutToAppear() {
        Logger.debug('CustomDialogView', 'aboutToAppear');
        // achievement dialog
        this.broadCast.on(BroadCastType.SHOW_ACHIEVEMENT_DIALOG, (achievementLevel) => {
            Logger.debug('CustomDialogView', 'SHOW_ACHIEVEMENT_DIALOG');
            this.achievementLevel = achievementLevel;
            this.achievementDialog.open();
        });
        // task clock dialog
        this.broadCast.on(BroadCastType.SHOW_TASK_DETAIL_DIALOG, (currentTask, dialogCallBack) => {
            Logger.debug('CustomDialogView', 'SHOW_TASK_DETAIL_DIALOG');
            this.currentTask = currentTask || TaskItem;
            this.dialogCallBack = dialogCallBack;
            this.taskDialog.open();
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
//# sourceMappingURL=CustomDialogView.js.map