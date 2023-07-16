import router from '@ohos.router';
import data_preferences from '@ohos.data.preferences';
import Logger from '../common/utils/Logger';
import { NICK_NAME, SIGNATURE, FULL_HEIGHT } from '../common/constants/CommonConstants';
import  PersonalImageDialogController  from '../view/dialog/PersonalImageDialog';
import  PersonalNicknameDialogController  from '../view/dialog/PersonalNicknameDialog';
import  PersonalSignatureDialogController  from '../view/dialog/PersonalSignatureDialog';
import  PersonalSexDialogController  from '../view/dialog/PersonalSexDialog';
import  PersonalDateDialogController  from '../view/dialog/PersonalDateDialog';
import  PersonalHighDialogController  from '../view/dialog/PersonalHighDialog';
import  PersonalWeightDialogController  from '../view/dialog/PersonalWeightDialog';
import { ZERO, MINUS_20 } from '../common/constants/CommonConstants';
@Entry
@Component
struct PersonalData{
  @Provide image : string = 'app.media.ic_user';
  @Provide nickname: string = NICK_NAME;
  @Provide signature: string = SIGNATURE;
  @Provide sex: string = '男'
  @Provide date: string = '2002-3-1'
  @Provide high: string = '180cm'
  @Provide weight: string = '60kg'
  PersonalImageDialogController: CustomDialogController = new CustomDialogController({
    builder: PersonalImageDialogController(),
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: ZERO, dy: MINUS_20 }
  });
  PersonalNicknameDialogController: CustomDialogController = new CustomDialogController({
    builder: PersonalNicknameDialogController(),
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: ZERO, dy: MINUS_20 }
  });
  PersonalSignatureDialogController: CustomDialogController = new CustomDialogController({
    builder: PersonalSignatureDialogController(),
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: ZERO, dy: MINUS_20 }
  });
  PersonalSexDialogController: CustomDialogController = new CustomDialogController({
    builder: PersonalSexDialogController(),
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: ZERO, dy: MINUS_20 }
  });
  PersonalDateDialogController: CustomDialogController = new CustomDialogController({
    builder: PersonalDateDialogController(),
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: ZERO, dy: MINUS_20 }
  });
  PersonalHighDialogController: CustomDialogController = new CustomDialogController({
    builder: PersonalHighDialogController(),
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: ZERO, dy: MINUS_20 }
  });
  PersonalWeightDialogController: CustomDialogController = new CustomDialogController({
    builder: PersonalWeightDialogController(),
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: ZERO, dy: MINUS_20 }
  });
  onPageShow(){
    let preferences = data_preferences.getPreferences(globalThis.context, "PersonalData");
    // let preferences = this.LastPages.preferences
    preferences.then((res)=>{
      if (res.has("image")) {
        res.get("image", 'app.media.ic_user').then((value) => {
          this.image = value.toString();
          Logger.info('PersonalData', 'image is get success');
        }).catch((err) => {
          Logger.info('PersonalData', 'image get failed. Cause:' + err);
        });
      }
      else {
        res.put("image",'app.media.ic_user').then(() => {
          this.image = 'app.media.ic_user'
          res.flush();
          Logger.info('PersonalData', 'image is put success');
        }).catch((err) => {
          Logger.info('PersonalData', 'image put failed. Cause:' + err);
        });
      }
        if (res.has("nickname")) {
          res.get("nickname", NICK_NAME).then((value) => {
            this.nickname = value.toString();
            Logger.info('PersonalData', 'nickname is get success');
          }).catch((err) => {
            Logger.info('PersonalData', 'nickname get failed. Cause:' + err);
          });
        }
        else {
          res.put("nickname", NICK_NAME).then(() => {
            this.nickname = NICK_NAME
            res.flush();
            Logger.info('PersonalData', 'nickname is put success');
          }).catch((err) => {
            Logger.info('PersonalData', 'nickname put failed. Cause:' + err);
          });
        }
      if (res.has("signature")) {
        res.get("signature", SIGNATURE).then((value) => {
          this.signature = value.toString();
          Logger.info('PersonalData', 'signature is get success');
        }).catch((err) => {
          Logger.info('PersonalData', 'signature get failed. Cause:' + err);
        });
      }
      else {
        res.put("signature", SIGNATURE).then(() => {
          res.flush();
          Logger.info('PersonalData', 'signature is put success');
        }).catch((err) => {
          Logger.info('PersonalData', 'signature put failed. Cause:' + err);
        });
      }
      if (res.has("sex")){
        res.get("sex", "男").then((value) =>{
          this.sex = value.toString()
          Logger.info('PersonalData', 'sex is get success');
        }).catch((err) => {
          Logger.info('PersonalData', 'sex is get failed. Cause:' + err);
        });
      }
      else{
        res.put("sex", "男").then(()=>{
          this.sex = "男"
          res.flush();
          Logger.info('PersonalData', 'sex is put success');
        }).catch((err)=>{
          Logger.info('PersonalData', 'sex is put failed. Cause:' + err);
        });
      }
      if (res.has("date")){
        res.get("date", "2002-3-1").then((value) =>{
          this.date = value.toString()
          Logger.info('PersonalData', 'date is get success');
        }).catch((err) => {
          Logger.info('PersonalData', 'date is get failed. Cause:' + err);
        });
      }
      else{
        res.put("date", "2002-3-1").then(()=>{
          this.date = "2002-3-1"
          res.flush();
          Logger.info('PersonalData', 'date is put success');
        }).catch((err)=>{
          Logger.info('PersonalData', 'date is put failed. Cause:' + err);
        });
      }
      if (res.has("high")){
        res.get("high", "180cm").then((value) =>{
          this.high = value.toString()
          Logger.info('PersonalData', 'high is get success');
        }).catch((err) => {
          Logger.info('PersonalData', 'high is get failed. Cause:' + err);
        });
      }
      else{
        res.put("high", "180cm").then(()=>{
          this.high = "180cm"
          res.flush();
          Logger.info('PersonalData', 'high is put success');
        }).catch((err)=>{
          Logger.info('PersonalData', 'high is put failed. Cause:' + err);
        });
      }
      if (res.has("weight")){
        res.get("weight", "60kg").then((value) =>{
          this.weight = value.toString()
          Logger.info('PersonalData', 'weight is get success');
        }).catch((err) => {
          Logger.info('PersonalData', 'weight is get failed. Cause:' + err);
        });
      }
      else{
        res.put("weight", "60kg").then(()=>{
          this.weight = "60kg"
          res.flush();
          Logger.info('PersonalData', 'weight is put success');
        }).catch((err)=>{
          Logger.info('PersonalData', 'weight is put failed. Cause:' + err);
        });
      }
    })
  }
  getImage(){
    if(this.image ==  'app.media.ic_user'){
      return $r('app.media.ic_user');
    }
    else{
      return this.image;
    }
  }
  build() {
      Column() {
          Row({space: 5}){
            Row().width(10)
            Column(){
              Image(this.getImage())
                .objectFit(ImageFit.Contain)
                .height($r('app.float.default_66'))
                .width($r('app.float.default_66'))
                .margin({ top: $r('app.float.default_71') })
                .onClick((event)=>{
                  this.PersonalImageDialogController.open()
                })
              Column() {
                Text('LV.7')
                  .fontSize($r('app.float.default_12'))
                  .fontWeight(FontWeight.Bolder)
                  .fontColor($r('app.color.leveColor'))
              }
              .width($r('app.float.default_44'))
              .height($r('app.float.default_16'))
              .margin({ top: $r('app.float.default_n8') })
              .border({ radius: $r('app.float.default_5') })
              .backgroundColor($r('app.color.leveBgColor'))
              .justifyContent(FlexAlign.Center)
            }
            Column(){
              Text(this.nickname)
                .onClick((event)=>{
                  this.PersonalNicknameDialogController.open()
                })
              Text(this.signature)
                .onClick((event)=>{
                  this.PersonalSignatureDialogController.open()
                })
            }.alignItems(HorizontalAlign.Start)
          }.alignItems(VerticalAlign.Bottom)
          .width('100%')
          .backgroundImagePosition({ x: 0, y: 0 })
          .backgroundImage($r('app.media.persona'))
          .backgroundImageSize({ width:'100%' } )
          .borderWidth({bottom:30})
          .borderColor($r('app.color.primaryBgColor'))
          .borderRadius({bottomLeft:15 ,bottomRight: 10})
        Row().width('100%').height('5%')
        Column(){
          Text(this.sex)
            .onClick((event)=>{
              this.PersonalSexDialogController.open()
            })
            .width('50%')
            .height('7%')
            .textAlign(TextAlign.Center)
            .fontColor('#e1585858')
            .backgroundImage($r('app.media.button'))
            .backgroundImageSize({width:'100%' ,height:'100%'})

          Text(this.date)
            .onClick((event)=>{
              this.PersonalDateDialogController.open()
            })
            .width('50%')
            .height('7%')
            .textAlign(TextAlign.Center)
            .fontColor('#e1585858')
            .backgroundImage($r('app.media.button'))
            .backgroundImageSize({width:'100%' ,height:'100%'})
          Text(this.high)
            .onClick((event)=>{
              this.PersonalHighDialogController.open()
            })
            .width('50%')
            .height('7%')
            .textAlign(TextAlign.Center)
            .fontColor('#e1585858')
            .backgroundImage($r('app.media.button'))
            .backgroundImageSize({width:'100%' ,height:'100%'})
          Text(this.weight)
            .onClick((event)=>{
              this.PersonalWeightDialogController.open()
            })
            .width('50%')
            .height('7%')
            .textAlign(TextAlign.Center)
            .fontColor('#e1585858')
            .backgroundImage($r('app.media.button'))
            .backgroundImageSize({width:'100%' ,height:'100%'})

          Button({ type: ButtonType.Capsule, stateEffect: true }){
            Row() {
              LoadingProgress().width(20).height(20).margin({ left: 12 }).color(0xFFFFFF)
              Text('Save').fontSize(12).fontColor(0xffffff).margin({ left: 5, right: 12 })
            }.alignItems(VerticalAlign.Center).width(90).height(40)
          }
            .backgroundColor('#a1838282')
            .onClick((event)=>{
              let preferences = data_preferences.getPreferences(globalThis.context, "PersonalData");
              preferences.then((res)=>{
                res.put("image", this.image)
                res.put("nickname", this.nickname)
                res.put("signature", this.signature)
                res.put("sex", this.sex)
                res.put("date", this.date)
                res.put("high", this.high)
                res.put("weight", this.weight)
                res.flush()
              })

              router.back({
                url: 'pages/MainPage',
              })

            })


        }.justifyContent(FlexAlign.SpaceEvenly)
        .height('70%')
        .width('95%')
        .backgroundImage($r('app.media.biankuang'))
        .backgroundImageSize({ width:'100%' ,height:'80%'})


      }
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.primaryBgColor'))
  }
}