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

import dataRdb from '@ohos.data.relationalStore';
import TaskInfo from '../../bean/TaskInfo';
import { TASK_INFO } from '../../constants/CommonConstants';
import RdbUtils from '../Rdb/RdbUtils';
import Logger from '../../utils/Logger';

class TaskInfoApi {
  /**
   * insert taskInfo
   *
   * @param taskInfo
   * @param callback
   */
  insertData(taskInfo: TaskInfo, callback): void {
    const valueBucket = generateBucket(taskInfo);
    RdbUtils.insert('taskInfo', valueBucket).then(result => {
      callback(result);
    });
    Logger.info('TaskInfoTable', `Insert taskInfo {${taskInfo.date}:${taskInfo.taskID}} finished.`);
  }

  /**
   * delete taskInfo
   *
   * @param taskInfo
   * @param callback
   */
  deleteDataByID(taskInfo: TaskInfo, callback): void {
    let predicates = new dataRdb.RdbPredicates(TASK_INFO.tableName);
    predicates.equalTo('date', taskInfo.date).and().equalTo('taskID', taskInfo.taskID);
    RdbUtils.del(predicates).then(result => {
      callback(result);
    });
    Logger.info('TaskInfoTable', `Delete taskInfo {${taskInfo.date}:${taskInfo.taskID}} finished.`);
  }

  /**
   * update taskInfo
   *
   * @param taskInfo
   * @param callback
   */
  updateDataByDate(taskInfo: TaskInfo, callback): void {
    const valueBucket = generateBucket(taskInfo);
    let predicates = new dataRdb.RdbPredicates(TASK_INFO.tableName);
    predicates.equalTo('date', taskInfo.date).and().equalTo('taskID', taskInfo.taskID);
    RdbUtils.update(valueBucket, predicates).then(result => {
      callback(result);
    });
    Logger.info('TaskInfoTable', `Update data {${taskInfo.date}:${taskInfo.taskID}} finished.`);
  }

  /**
   * query taskInfo
   *
   * @param date
   * @param callback
   */
  query(date: string, isOpen: boolean = true, callback): void {
    let predicates = new dataRdb.RdbPredicates(TASK_INFO.tableName);
    predicates.equalTo('date', date);
    if (isOpen) {
      predicates.equalTo('isOpen', true);
    }
    predicates.orderByAsc('taskID');
    RdbUtils.query(predicates).then(resultSet => {
      let count = resultSet.rowCount;
      if (count === 0 || typeof count === 'string') {
        Logger.error('TaskInfoTable', `${date} query no results!`);
        callback([]);
      } else {
        resultSet.goToFirstRow();
        const result = [];
        for (let i = 0; i < count; i++) {
          let tmp = new TaskInfo(0, '', 0, '', false, '', '', '', false, '');
          tmp.isOpen = resultSet.getDouble(resultSet.getColumnIndex('isOpen')) ? true : false;
          tmp.id = resultSet.getDouble(resultSet.getColumnIndex('id'));
          tmp.date = resultSet.getString(resultSet.getColumnIndex('date'));
          tmp.taskID = resultSet.getDouble(resultSet.getColumnIndex('taskID'));
          tmp.targetValue = resultSet.getString(resultSet.getColumnIndex('targetValue'));
          tmp.isAlarm = resultSet.getDouble(resultSet.getColumnIndex('isAlarm')) ? true : false;
          tmp.startTime = resultSet.getString(resultSet.getColumnIndex('startTime'));
          tmp.endTime = resultSet.getString(resultSet.getColumnIndex('endTime'));
          tmp.frequency = resultSet.getString(resultSet.getColumnIndex('frequency'));
          tmp.isDone = resultSet.getDouble(resultSet.getColumnIndex('isDone')) ? true : false;
          tmp.finValue = resultSet.getString(resultSet.getColumnIndex('finValue'));
          result[i] = tmp;
          resultSet.goToNextRow();
        }
        callback(result);
      }
    });
  }

  //增加查询单项任务的api，吃苹果为例
  query_apple(date: string, isOpen: boolean = true, callback): void {
    let predicates = new dataRdb.RdbPredicates(TASK_INFO.tableName);
    predicates.equalTo('date', date).and().equalTo('taskID', 3);

    //predicates.equalTo('taskID', 3 );

    if (isOpen) {
      predicates.equalTo('isOpen', true);
    }
    //predicates.orderByAsc('taskID');
    RdbUtils.query(predicates).then(resultSet => {
      let count = resultSet.rowCount;
      if (count === 0 || typeof count === 'string') {
        Logger.error('TaskInfoTable', `${date} query no results!`);
        callback([]);
      } else {
        resultSet.goToFirstRow();
        const result = [];
        for (let i = 0; i < count; i++) {
          let tmp = new TaskInfo(0, '', 0, '', false, '', '', '', false, '');
          tmp.isOpen = resultSet.getDouble(resultSet.getColumnIndex('isOpen')) ? true : false;
          tmp.id = resultSet.getDouble(resultSet.getColumnIndex('id'));
          tmp.date = resultSet.getString(resultSet.getColumnIndex('date'));
          tmp.taskID = resultSet.getDouble(resultSet.getColumnIndex('taskID'));
          tmp.targetValue = resultSet.getString(resultSet.getColumnIndex('targetValue'));
          tmp.isAlarm = resultSet.getDouble(resultSet.getColumnIndex('isAlarm')) ? true : false;
          tmp.startTime = resultSet.getString(resultSet.getColumnIndex('startTime'));
          tmp.endTime = resultSet.getString(resultSet.getColumnIndex('endTime'));
          tmp.frequency = resultSet.getString(resultSet.getColumnIndex('frequency'));
          tmp.isDone = resultSet.getDouble(resultSet.getColumnIndex('isDone')) ? true : false;
          tmp.finValue = resultSet.getString(resultSet.getColumnIndex('finValue'));
          result[i] = tmp;
          resultSet.goToNextRow();
        }
        callback(result);
      }
    });
  }

  // 查询当天已经完成的任务
  queryDone(date: string, callback): void {
    let predicates = new dataRdb.RdbPredicates(TASK_INFO.tableName);
    predicates.equalTo('date', date);
    predicates.equalTo('isOpen', true);
    predicates.equalTo('isDone', true);
    predicates.orderByAsc('taskID');
    RdbUtils.query(predicates).then(resultSet => {
      let count = resultSet.rowCount;
      if (count === 0 || typeof count === 'string') {
        Logger.error('TaskInfoTable', `${date} query no results!`);
        callback([]);
      } else {
        resultSet.goToFirstRow();
        const result = [];
        for (let i = 0; i < count; i++) {
          let tmp = new TaskInfo(0, '', 0, '', false, '', '', '', false, '');
          tmp.isOpen = resultSet.getDouble(resultSet.getColumnIndex('isOpen')) ? true : false;
          tmp.id = resultSet.getDouble(resultSet.getColumnIndex('id'));
          tmp.date = resultSet.getString(resultSet.getColumnIndex('date'));
          tmp.taskID = resultSet.getDouble(resultSet.getColumnIndex('taskID'));
          tmp.targetValue = resultSet.getString(resultSet.getColumnIndex('targetValue'));
          tmp.isAlarm = resultSet.getDouble(resultSet.getColumnIndex('isAlarm')) ? true : false;
          tmp.startTime = resultSet.getString(resultSet.getColumnIndex('startTime'));
          tmp.endTime = resultSet.getString(resultSet.getColumnIndex('endTime'));
          tmp.frequency = resultSet.getString(resultSet.getColumnIndex('frequency'));
          tmp.isDone = resultSet.getDouble(resultSet.getColumnIndex('isDone')) ? true : false;
          tmp.finValue = resultSet.getString(resultSet.getColumnIndex('finValue'));
          result[i] = tmp;
          resultSet.goToNextRow();
        }
        callback(result);
      }
    });
  }

  // 查询任务总量(跑步或吃苹果）
  queryHistorySum(taskIDSearch:number, callback): void {
    let predicates = new dataRdb.RdbPredicates(TASK_INFO.tableName);
    // predicates.equalTo('date', date);
    predicates.equalTo('isOpen', true);
    predicates.equalTo('taskID', taskIDSearch);
    // predicates.equalTo('isDone', true);
    RdbUtils.query(predicates).then(resultSet => {
      let count = resultSet.rowCount;
      let runSum: number = 0;
      if (count === 0 || typeof count === 'string') {
        Logger.error('TaskInfoTable', `run sum query no results!`);
        callback(0);
      } else {
        resultSet.goToFirstRow();
        for (let i = 0; i < count; i++) {
          runSum += Number(resultSet.getString(resultSet.getColumnIndex('finValue')));
          resultSet.goToNextRow();
        }
        callback(runSum);
      }
    });
  }





}




function generateBucket(taskInfo: TaskInfo): dataRdb.ValuesBucket {
  let valueBucket = {};
  TASK_INFO.columns.forEach((item: string) => {
    if (item !== 'id') {
      valueBucket[item] = taskInfo[item];
    }
  });
  return valueBucket;
}

let taskInfoApi = new TaskInfoApi();

export default taskInfoApi as TaskInfoApi;