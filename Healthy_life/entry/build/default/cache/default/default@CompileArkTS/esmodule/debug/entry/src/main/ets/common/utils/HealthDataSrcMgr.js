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
import { BroadCast } from '@bundle:com.example.healthy_life/entry/ets/common/utils/BroadCast';
import Logger from '@bundle:com.example.healthy_life/entry/ets/common/utils/Logger';
const APP_KEY_GROUP_DATA_SOURCE_MANAGER = 'app_key_group_data_source_manager';
export class HealthDataSrcMgr {
    constructor() {
        Logger.debug('HealthDataSourceManager', 'constructor');
        this.broadCast = new BroadCast();
    }
    static getInstance() {
        if (AppStorage.Get(APP_KEY_GROUP_DATA_SOURCE_MANAGER) == null) {
            AppStorage.SetOrCreate(APP_KEY_GROUP_DATA_SOURCE_MANAGER, new HealthDataSrcMgr());
        }
        return AppStorage.Get(APP_KEY_GROUP_DATA_SOURCE_MANAGER);
    }
    getBroadCast() {
        return this.broadCast;
    }
}
//# sourceMappingURL=HealthDataSrcMgr.js.map