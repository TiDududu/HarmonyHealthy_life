/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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
import dataRdb from '@ohos:data.relationalStore';
import DayInfo from '@bundle:com.example.healthy_life/entry/ets/common/bean/DayInfo';
import { DAY_INFO } from '@bundle:com.example.healthy_life/entry/ets/common/constants/CommonConstants';
import RdbUtils from '@bundle:com.example.healthy_life/entry/ets/common/database/rdb/RdbUtils';
import Logger from '@bundle:com.example.healthy_life/entry/ets/common/utils/Logger';
class DayInfoApi {
    /**
     * Insert dayInfo.
     *
     * @param dayInfo
     * @param callback
     */
    insertData(dayInfo, callback) {
        const valueBucket = generateBucket(dayInfo);
        RdbUtils.insert('dayInfo', valueBucket).then(result => {
            callback(result);
        });
        Logger.info('DayInfoTable', 'Insert dayInfo finished.');
    }
    /**
     * Update dayInfo.
     *
     * @param dayInfo
     * @param callback
     */
    updateData(dayInfo, callback) {
        const valueBucket = generateBucket(dayInfo);
        let predicates = new dataRdb.RdbPredicates(DAY_INFO.tableName);
        predicates.equalTo('date', dayInfo.date);
        RdbUtils.update(valueBucket, predicates).then(result => {
            callback(result);
        });
        Logger.info('DayInfoTable', 'Update dayInfo finished.');
    }
    /**
     * Query dayInfo.
     *
     * @param date
     * @param callback
     */
    query(date, callback) {
        let predicates = new dataRdb.RdbPredicates(DAY_INFO.tableName);
        predicates.equalTo('date', date);
        RdbUtils.query(predicates).then(resultSet => {
            let count = resultSet.rowCount;
            if (count === 0) {
                Logger.info('DayInfoTable', 'query no results.');
                callback([]);
            }
            else {
                let result = new DayInfo('', 0, 0);
                resultSet.goToFirstRow();
                result.date = resultSet.getString(resultSet.getColumnIndex('date'));
                result.targetTaskNum = resultSet.getDouble(resultSet.getColumnIndex('targetTaskNum'));
                result.finTaskNum = resultSet.getDouble(resultSet.getColumnIndex('finTaskNum'));
                callback(result);
            }
            return;
        });
    }
    /**
     * Query dayInfo list.
     *
     * @param date
     * @param callback
     */
    queryList(dates, callback) {
        let predicates = new dataRdb.RdbPredicates(DAY_INFO.tableName);
        predicates.in('date', dates);
        RdbUtils.query(predicates).then(resultSet => {
            let count = resultSet.rowCount;
            if (count === 0) {
                Logger.info('DayInfoTable', 'query no results.');
                callback([]);
            }
            else {
                resultSet.goToFirstRow();
                let result = [];
                for (let i = 0; i < count; i++) {
                    let tmp = new DayInfo('', 0, 0);
                    tmp.date = resultSet.getString(resultSet.getColumnIndex('date'));
                    tmp.targetTaskNum = resultSet.getDouble(resultSet.getColumnIndex('targetTaskNum'));
                    tmp.finTaskNum = resultSet.getDouble(resultSet.getColumnIndex('finTaskNum'));
                    result[i] = tmp;
                    resultSet.goToNextRow();
                }
                callback(result);
            }
        });
    }
}
function generateBucket(dayInfo) {
    let valueBucket = {};
    DAY_INFO.columns.forEach((item) => {
        valueBucket[item] = dayInfo[item];
    });
    return valueBucket;
}
let dayInfoApi = new DayInfoApi();
export default dayInfoApi;
//# sourceMappingURL=DayInfoApi.js.map