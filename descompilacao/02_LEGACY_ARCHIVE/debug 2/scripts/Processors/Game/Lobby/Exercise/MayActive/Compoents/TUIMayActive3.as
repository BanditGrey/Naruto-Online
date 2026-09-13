package Processors.Game.Lobby.Exercise.MayActive.Compoents
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TBB_Status;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.Exercise.MayActive.TMayActive3;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.MayActive.TProcessorMayActive;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.clearInterval;
   import flash.utils.clearTimeout;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIMayActive3 extends TUIBaseWindow
   {
      
      public static const ACTIVITY_3_ID:int = 3;
      
      public static const SOLDIER_COUNT:int = 3;
      
      public static const GIFT_COUNT:int = 3;
      
      public static const KILL_GIFT_COUNT:int = 2;
      
      public static const BOX_COUNT:int = 5;
      
      public static const HERO_COUNT:int = 2;
      
      public static const MOVIE_GOTO_NEW_MAP:int = 1;
      
      public static const MOVIE_REFRESH_MONSTER:int = 2;
      
      public static const MOVIE_TYPE_BEAT_MONSTER:int = 3;
      
      public static const MOVIE_TYPE_BEAT_BOSS:int = 4;
      
      public static const MOVIE_TYPE_BOSS_DIED:int = 5;
      
      public static const MOVIE_DROP_BOX:int = 6;
      
      public static const INTERVAL_TIME:int = 1000 * 60;
      
      protected var FSoldierList:Vector.<MovieClip>;
      
      protected var FGiftList:Vector.<MovieClip>;
      
      protected var FKillGiftList:Vector.<MovieClip>;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FHeroList:Vector.<MovieClip>;
      
      protected var FHeadBitmapVect:Vector.<Bitmap>;
      
      protected var FHeadIconList:Vector.<uint>;
      
      protected var FHeadIconType:Vector.<int>;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FTF_SoldierTime:TextField;
      
      protected var FTF_RefreshTime:TextField;
      
      protected var FTF_BossTime:TextField;
      
      protected var FMayActive3:TMayActive3;
      
      protected var FHasRefresh:Boolean;
      
      protected var FIsShowBoss:Boolean;
      
      protected var FBarMaxWidth:int;
      
      protected var FMovieType:int;
      
      protected var FDropBoxIndex:int;
      
      protected var FIsWaiting:Boolean;
      
      protected var FBossHpTimeID:int;
      
      public function TUIMayActive3(param1:TUIComponent)
      {
         super(param1);
         this.FSoldierList = new Vector.<MovieClip>(SOLDIER_COUNT);
         this.FGiftList = new Vector.<MovieClip>(GIFT_COUNT);
         this.FKillGiftList = new Vector.<MovieClip>(KILL_GIFT_COUNT);
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FHeroList = new Vector.<MovieClip>(HERO_COUNT);
         this.FHeadBitmapVect = new Vector.<Bitmap>(HERO_COUNT);
         this.FHeadIconList = new Vector.<uint>(HERO_COUNT);
         this.FHeadIconType = new Vector.<int>(HERO_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIBaseBox = null;
         super.Resources_UIDispatch(param1);
         this.FTF_SoldierTime = FMC_Scene.TF_SoldierTime;
         this.FTF_RefreshTime = FMC_Scene.TF_RefreshTime;
         this.FTF_BossTime = FMC_Scene.TF_BossTime;
         _loc2_ = 0;
         while(_loc2_ < SOLDIER_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Soldier" + _loc2_];
            _loc4_.MC_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSoldierOver);
            _loc4_.MC_Icon.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
            TGameUtil.setButtonMode(_loc4_.BTN_Buy,true);
            _loc4_.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnSoldierUp);
            TGameUtil.setButtonMode(_loc4_.BTN_Fire,true);
            _loc4_.BTN_Fire.addEventListener(MouseEvent.CLICK,this.ProcessorOnFireUp);
            this.FSoldierList[_loc2_] = _loc4_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < GIFT_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Gift" + _loc2_];
            _loc4_.buttonMode = true;
            _loc4_.MC_Icon.gotoAndStop(_loc2_ + 1);
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnGiftOut);
            _loc4_.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
            this.FGiftList[_loc2_] = _loc4_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < KILL_GIFT_COUNT)
         {
            _loc4_ = FMC_Scene["MC_KillGift" + _loc2_];
            _loc4_.MC_Box.buttonMode = true;
            _loc4_.MC_Box.MC_Icon.gotoAndStop(_loc2_ + 1);
            _loc4_.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnKillGiftOver);
            _loc4_.MC_Box.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnKillGiftOut);
            _loc4_.MC_Box.addEventListener(MouseEvent.CLICK,this.ProcessorOnKillGiftUp);
            this.FKillGiftList[_loc2_] = _loc4_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Box" + _loc2_];
            _loc4_.MC_Box.buttonMode = true;
            _loc4_.MC_Box.MC_Icon.gotoAndStop(_loc2_ + 1);
            _loc4_.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            _loc4_.MC_Box.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            _loc4_.MC_Box.addEventListener(MouseEvent.CLICK,this.ProcessorOnBoxUp);
            this.FBoxList[_loc2_] = _loc4_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < HERO_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Hero" + _loc2_];
            _loc4_.MC_Tip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
            _loc4_.MC_Tip.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnHeroOut);
            TGameUtil.setButtonMode(_loc4_.Btn_Get,true);
            _loc4_.Btn_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetHeroUp);
            TGameUtil.setButtonMode(_loc4_.Btn_Recruit,true);
            _loc4_.Btn_Recruit.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroUp);
            this.FHeadBitmapVect[_loc2_] = new Bitmap();
            _loc4_.MC_Hero.addChild(this.FHeadBitmapVect[_loc2_]);
            this.FHeroList[_loc2_] = _loc4_;
            _loc2_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.BTN_Back,true);
         FMC_Scene.BTN_Back.addEventListener(MouseEvent.CLICK,this.ProcessorOnBackUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Boss,true);
         FMC_Scene.BTN_Boss.addEventListener(MouseEvent.CLICK,this.ProcessorOnBossUp);
         FMC_Scene.BTN_Boss.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBossOver);
         FMC_Scene.BTN_Boss.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBossOut);
         TGameUtil.setButtonMode(FMC_Scene.MC_Boss.BTN_Attack,true);
         FMC_Scene.MC_Boss.BTN_Attack.addEventListener(MouseEvent.CLICK,this.ProcessorOnAttackUp);
         FMC_Scene.MC_Boss.BTN_Attack.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnAttackOver);
         FMC_Scene.MC_Boss.BTN_Attack.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Go,true);
         FMC_Scene.BTN_Go.addEventListener(MouseEvent.CLICK,this.ProcessorOnGoUp);
         FMC_Scene.BTN_Go.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGoOver);
         FMC_Scene.BTN_Go.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Rank,true);
         FMC_Scene.BTN_Rank.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadRank);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLogUp);
         FMC_Scene.BTN_AddAP.addEventListener(MouseEvent.CLICK,this.ProcessorOnAddAPUp);
         FMC_Scene.BTN_AddAP.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnAddAPOver);
         FMC_Scene.BTN_AddAP.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.BTN_AddMP.addEventListener(MouseEvent.CLICK,this.ProcessorOnAddMpUp);
         FMC_Scene.BTN_AddMP.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnAddMpOver);
         FMC_Scene.BTN_AddMP.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_MySoldier.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnMySoldierOver);
         FMC_Scene.MC_MySoldier.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_Boss.MC_Tip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBossTipOver);
         FMC_Scene.MC_Boss.MC_Tip.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_PowerTip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnPowerOver);
         FMC_Scene.MC_PowerTip.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         this.FMC_Mask = FMC_Scene.MC_Boss.MC_Bar.MC_Mask;
         if(this.FMC_Mask)
         {
            this.FBarMaxWidth = this.FMC_Mask.width;
         }
         FMC_Scene.MC_GiftEffect.visible = false;
      }
      
      protected function UpdateSoldier() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         _loc4_ = this.FMayActive3.MySoldier;
         FMC_Scene.MC_MySoldier.gotoAndStop(_loc4_.Type + 1);
         if(_loc4_.Type == 0)
         {
            FMC_Scene.MC_MySoldier.gotoAndStop(1);
            FMC_Scene.TF_Name.text = this.FMayActive3.DescListNew[3];
            this.FTF_SoldierTime.text = "";
            _loc6_ = "<font color=\"#ffffff\">%0 </font>";
            FMC_Scene.TF_Power.htmlText = TUtilityString.Format(_loc6_,this.FMayActive3.MyPower);
         }
         else
         {
            FMC_Scene.MC_MySoldier.gotoAndStop(_loc4_.Type + 1);
            FMC_Scene.TF_Name.text = this.FMayActive3.SoldierList[_loc4_.Type - 1].Desc2;
            this.FTF_SoldierTime.text = TUtilityString.Format(this.FMayActive3.DescListNew[2],_loc4_.Time);
            _loc6_ = "<font color=\"#ffffff\">%0 + </font>" + "<font color=\"#65FECB\">%1</font>";
            FMC_Scene.TF_Power.htmlText = TUtilityString.Format(_loc6_,this.FMayActive3.MyPower,this.FMayActive3.MySoldier.Level);
         }
         _loc1_ = 0;
         while(_loc1_ < SOLDIER_COUNT)
         {
            _loc3_ = this.FSoldierList[_loc1_];
            _loc4_ = this.FMayActive3.SoldierList[_loc1_];
            _loc3_.MC_Icon.gotoAndStop(_loc4_.Type);
            _loc3_.TF_Power.text = _loc4_.Level.toString();
            if(_loc4_.Status == TBaseActivity.STATUS_GETED)
            {
               _loc3_.BTN_Fire.visible = true;
               _loc3_.BTN_Buy.visible = false;
               TGameUtil.setButtonMode(_loc3_.BTN_Buy,false);
            }
            else if(this.FMayActive3.MySoldier.Type != 0)
            {
               _loc3_.BTN_Fire.visible = false;
               _loc3_.BTN_Buy.visible = true;
               TGameUtil.setButtonMode(_loc3_.BTN_Buy,false);
            }
            else
            {
               _loc3_.BTN_Fire.visible = false;
               _loc3_.BTN_Buy.visible = true;
               TGameUtil.setButtonMode(_loc3_.BTN_Buy,true);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateMonster() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TBaseBox = null;
         if(this.FIsShowBoss)
         {
            FMC_Scene.BTN_Boss.visible = false;
            FMC_Scene.BTN_Back.visible = true;
            FMC_Scene.MC_Boss.visible = true;
            FMC_Scene.BTN_Go.visible = false;
            _loc4_ = this.FMayActive3.CurBoss;
            if(_loc4_.Min <= 0)
            {
               FMC_Scene.MC_Boss.MC_KillMovie.gotoAndStop(_loc4_.Type * 2);
            }
            else
            {
               FMC_Scene.MC_Boss.MC_KillMovie.gotoAndStop(_loc4_.Type * 2 - 1);
            }
         }
         else
         {
            FMC_Scene.BTN_Boss.visible = true;
            FMC_Scene.BTN_Back.visible = false;
            _loc4_ = this.FMayActive3.CurMonster;
            if(_loc4_.Type == 0 || _loc4_.Min <= 0)
            {
               FMC_Scene.MC_Boss.visible = false;
               FMC_Scene.BTN_Go.visible = true;
            }
            else
            {
               FMC_Scene.MC_Boss.visible = true;
               FMC_Scene.BTN_Go.visible = false;
               FMC_Scene.MC_Boss.MC_KillMovie.gotoAndStop(_loc4_.Type * 2 - 1);
            }
         }
         if(this.FMayActive3.BossIsAppear == 0)
         {
            if(FMC_Scene.BTN_Boss.MC_Shine)
            {
               FMC_Scene.BTN_Boss.MC_Shine.gotoAndStop(1);
            }
         }
         else if(FMC_Scene.BTN_Boss.MC_Shine)
         {
            if(this.FMayActive3.CurBoss.Min <= 0)
            {
               FMC_Scene.BTN_Boss.MC_Shine.gotoAndStop(1);
            }
            else
            {
               FMC_Scene.BTN_Boss.MC_Shine.gotoAndPlay(1);
            }
         }
         FMC_Scene.MC_Boss.MC_RefreshMovie.visible = false;
         FMC_Scene.MC_Boss.MC_BeatMovie.visible = false;
         FMC_Scene.MC_Boss.MC_Bar.TF_Count.text = _loc4_.Min + "/" + _loc4_.Max;
         _loc2_ = Number(_loc4_.Min / _loc4_.Max) * this.FBarMaxWidth;
         _loc3_ = Math.min(_loc2_,this.FBarMaxWidth);
         TweenUtil.to(this.FMC_Mask,1000,{"width":_loc3_});
      }
      
      protected function UpdateHero() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:TRoleModel = null;
         var _loc6_:TBaseHero = null;
         var _loc7_:TBB_Status = null;
         _loc1_ = 0;
         while(_loc1_ < HERO_COUNT)
         {
            _loc3_ = this.FHeroList[_loc1_];
            if(_loc1_ < this.FMayActive3.SpecialReward.length)
            {
               _loc4_ = this.FMayActive3.SpecialReward[_loc1_];
               _loc3_.MC_Count.TF_Count.text = "*" + _loc4_.Price;
               if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc3_.MC_Got.visible = false;
                  TGameUtil.setButtonMode(_loc3_.Btn_Get,true);
               }
               else if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc3_.MC_Got.visible = false;
                  TGameUtil.setButtonMode(_loc3_.Btn_Get,false);
               }
               else
               {
                  _loc3_.MC_Got.visible = true;
                  TGameUtil.setButtonMode(_loc3_.Btn_Get,false);
               }
               if(_loc4_.Type == TBaseBox.TYPE_IS_HERO)
               {
                  _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc4_.Identify) as TBaseHero;
                  _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc4_.Identify) as TRoleModel;
                  this.FHeadIconList[_loc1_] = _loc5_.RoleHead;
                  this.FHeadIconType[_loc1_] = TGameUtil.Type_HeadIcon;
                  _loc3_.TF_Name.text = _loc6_.Name;
                  _loc3_.Btn_Recruit.visible = true;
                  _loc3_.MC_BoxPic.visible = false;
               }
               else if(_loc4_.Type == TBaseBox.TYPE_IS_PET)
               {
                  _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,_loc4_.Identify) as TBB_Status;
                  this.FHeadIconList[_loc1_] = _loc7_.SmPic;
                  this.FHeadIconType[_loc1_] = TGameUtil.Type_Pet;
                  _loc3_.TF_Name.text = _loc7_.Name;
                  _loc3_.Btn_Recruit.visible = true;
                  _loc3_.MC_BoxPic.visible = false;
               }
               else
               {
                  _loc3_.MC_BoxPic.visible = true;
                  this.FHeadIconList[_loc1_] = 0;
                  this.FHeadIconType[_loc1_] = -1;
                  _loc3_.TF_Name.text = "";
                  _loc3_.Btn_Recruit.visible = false;
               }
               if(_loc1_ == 1)
               {
                  _loc3_.Btn_Get.visible = false;
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < GIFT_COUNT)
         {
            _loc3_ = this.FGiftList[_loc1_];
            if(_loc1_ < this.FMayActive3.GiftList.length)
            {
               _loc4_ = this.FMayActive3.GiftList[_loc1_];
               _loc3_.TF_Num.text = _loc4_.Count;
               if(_loc4_.Count > 0)
               {
                  _loc3_.MC_Click.visible = true;
               }
               else
               {
                  _loc3_.MC_Click.visible = false;
               }
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < KILL_GIFT_COUNT)
         {
            _loc3_ = this.FKillGiftList[_loc1_];
            if(_loc1_ < this.FMayActive3.KillReward.length)
            {
               _loc4_ = this.FMayActive3.KillReward[_loc1_];
               _loc3_.TF_Count.text = _loc4_.Count + "/" + _loc4_.Price;
               _loc3_.MC_Box.MC_Icon.gotoAndStop(_loc1_ + 1);
               if(_loc4_.Count >= _loc4_.Price)
               {
                  _loc3_.MC_Click.visible = true;
               }
               else
               {
                  _loc3_.MC_Click.visible = false;
               }
            }
            _loc1_++;
         }
         _loc5_ = this.FMayActive3.BoxList[this.FMayActive3.BoxList.length - 1];
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FBoxList[_loc1_];
            if(_loc1_ < this.FMayActive3.BoxList.length)
            {
               _loc4_ = this.FMayActive3.BoxList[_loc1_];
               _loc3_.MC_Count.TF_Count.text = TUtilityString.Format(this.FMayActive3.DescListNew[8],_loc4_.Price + (this.FMayActive3.RewardRound - 1) * _loc5_.Price);
               if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc3_.MC_Box.gotoAndPlay(1);
               }
               else if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc3_.MC_Box.gotoAndStop(1);
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TInventories = null;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FMayActive3.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FMayActive3.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FMayActive3.DescListNew[1];
         FMC_Scene.TF_AP.text = this.FMayActive3.APValue + "/" + this.FMayActive3.MaxAP;
         FMC_Scene.TF_MP.text = this.FMayActive3.MPValue + "/" + this.FMayActive3.MaxMP;
         FMC_Scene.TF_Score.text = this.FMayActive3.RankPoint.toString();
         FMC_Scene.TF_BossDesc.htmlText = this.FMayActive3.DescListNew[18];
      }
      
      public function UpdataBitmap() : void
      {
         var _loc1_:int = 0;
         if(Boolean(this.FMayActive3) && Boolean(this.FMayActive3.SpecialReward.length > 0) && this.FHeroList.length > 0)
         {
            if(this.FHeadIconType[0] >= 0)
            {
               this.FHeroList[0].MC_Hero.x = 12 + (70 - this.FHeadBitmapVect[0].width) / 2;
               this.FHeroList[0].MC_Hero.y = 12 + (77 - this.FHeadBitmapVect[0].height) / 2;
               TGameUtil.ShowImageByID(this.FHeadIconType[0],this.FHeadBitmapVect[0],CONST_MODULES.ACTIVE_Test,this.FHeadIconList[0]);
            }
            if(this.FHeadIconType[1] >= 0)
            {
               this.FHeroList[1].MC_Hero.x = 77 + (80 - this.FHeadBitmapVect[1].width) / 2;
               this.FHeroList[1].MC_Hero.y = 14 + (54 - this.FHeadBitmapVect[1].height) / 2;
               TGameUtil.ShowImageByID(this.FHeadIconType[1],this.FHeadBitmapVect[1],CONST_MODULES.ACTIVE_Test,this.FHeadIconList[1]);
            }
         }
      }
      
      protected function SetInterval() : void
      {
         var _loc1_:Number = NaN;
         if(this.FBossHpTimeID != 0)
         {
            clearInterval(this.FBossHpTimeID);
            this.FBossHpTimeID = 0;
         }
         if(this.FMayActive3.BossIsAppear != 0 && this.FMayActive3.CurBoss.Min > 0)
         {
            this.FBossHpTimeID = setInterval(this.ProcessorOnBossStatusReq,INTERVAL_TIME);
         }
      }
      
      protected function ProcessorOnBossStatusReq() : void
      {
         if(FOnIntervalFun != null)
         {
            FOnIntervalFun();
         }
      }
      
      protected function ProcessorOnSoldierUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(10));
         if(Boolean(FOnBuyBox != null && this.FMayActive3) && Boolean(_loc2_ < this.FMayActive3.SoldierList.length) && !FIsPlaying)
         {
            FOnBuyBox(ACTIVITY_3_ID,TProcessorMayActive.ACTIVITY_3_BUY_SOLDIER,this.FMayActive3.SoldierList[_loc2_].Price,_loc2_ + 1,TBaseActivity.SWEET_TYPE_GOLD);
         }
      }
      
      protected function ProcessorOnFireUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(10));
         if(Boolean(FOnBuyBox != null && this.FMayActive3) && Boolean(_loc2_ < this.FMayActive3.SoldierList.length) && !FIsPlaying)
         {
            FOnBuyBox(ACTIVITY_3_ID,TProcessorMayActive.ACTIVITY_3_FIRE_SOLDIER,0,_loc2_ + 1,TBaseActivity.SWEET_TYPE_GOLD,this.FMayActive3.DescListNew[16]);
         }
      }
      
      protected function ProcessorOnGoUp(param1:MouseEvent) : void
      {
         if(Boolean(FOnGetBox != null && this.FMayActive3) && Boolean(!FIsPlaying) && !this.FIsWaiting)
         {
            if(this.FMayActive3.APValue >= 10)
            {
               FOnGetBox(ACTIVITY_3_ID,TProcessorMayActive.ACTIVITY_3_GOTO_NEW_MAP,0);
            }
            else
            {
               FOnBuyBox(ACTIVITY_3_ID,TProcessorMayActive.ACTIVITY_3_ADD_AP,this.FMayActive3.AddAPCost,0,TBaseActivity.SWEET_TYPE_GOLD,this.FMayActive3.DescListNew[9]);
            }
         }
      }
      
      protected function ProcessorOnAttackUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(Boolean(FOnGetBox != null && this.FMayActive3) && Boolean(!this.FIsWaiting) && !FIsPlaying)
         {
            _loc2_ = this.FMayActive3.MyPower + this.FMayActive3.MySoldier.Level;
            if(this.FMayActive3.MPValue >= _loc2_)
            {
               if(this.FIsShowBoss)
               {
                  if(this.FMayActive3.CurBoss.Min > 0)
                  {
                     FOnGetBox(ACTIVITY_3_ID,TProcessorMayActive.ACTIVITY_3_ATTACK_BOSS,0);
                  }
               }
               else
               {
                  FOnGetBox(ACTIVITY_3_ID,TProcessorMayActive.ACTIVITY_3_ATTACK_MONSTER,0);
               }
            }
            else
            {
               FOnBuyBox(ACTIVITY_3_ID,TProcessorMayActive.ACTIVITY_3_ADD_MP,this.FMayActive3.AddMPCost,0,TBaseActivity.SWEET_TYPE_GOLD,this.FMayActive3.DescListNew[10]);
            }
         }
      }
      
      protected function ProcessorOnAddAPUp(param1:MouseEvent) : void
      {
         if(FOnBuyBox != null && Boolean(this.FMayActive3))
         {
            FOnBuyBox(ACTIVITY_3_ID,TProcessorMayActive.ACTIVITY_3_ADD_AP,this.FMayActive3.AddAPCost,0,TBaseActivity.SWEET_TYPE_GOLD,this.FMayActive3.DescListNew[9]);
         }
      }
      
      protected function ProcessorOnAddMpUp(param1:MouseEvent) : void
      {
         if(FOnBuyBox != null && Boolean(this.FMayActive3))
         {
            FOnBuyBox(ACTIVITY_3_ID,TProcessorMayActive.ACTIVITY_3_ADD_MP,this.FMayActive3.AddMPCost,0,TBaseActivity.SWEET_TYPE_GOLD,this.FMayActive3.DescListNew[10]);
         }
      }
      
      protected function ProcessorOnBackUp(param1:MouseEvent) : void
      {
         this.FIsShowBoss = false;
         this.UpdateUI();
      }
      
      protected function ProcessorOnBossUp(param1:MouseEvent) : void
      {
         if(this.FMayActive3.BossIsAppear == 0)
         {
            FMC_Scene.BTN_Boss.MC_Shine.gotoAndStop(1);
            FOnShowFlowText(this.FMayActive3.DescListNew[20]);
            return;
         }
         this.FIsShowBoss = true;
         this.UpdateUI();
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(FOnGetBox != null && this.FMayActive3) && Boolean(_loc2_ < this.FMayActive3.GiftList.length) && this.FMayActive3.GiftList[_loc2_].Count > 0)
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorMayActive.ACTIVITY_3_GET_GIFT,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(FOnGetBox != null && this.FMayActive3) && Boolean(_loc2_ < this.FMayActive3.BoxList.length) && this.FMayActive3.BoxList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorMayActive.ACTIVITY_3_GET_BOX,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnKillGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(11));
         if(Boolean(FOnGetBox != null && this.FMayActive3) && Boolean(_loc2_ < this.FMayActive3.KillReward.length) && this.FMayActive3.KillReward[_loc2_].Count >= this.FMayActive3.KillReward[_loc2_].Price)
         {
            if(_loc2_ == 0)
            {
               FOnGetBox(ACTIVITY_3_ID,TProcessorMayActive.ACTIVITY_3_GET_KILL_MONSTER_BOX,_loc2_ + 1);
            }
            else
            {
               FOnGetBox(ACTIVITY_3_ID,TProcessorMayActive.ACTIVITY_3_GET_KILL_BOSS_BOX,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnGetHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnGetBox != null) && Boolean(this.FMayActive3) && _loc2_ < this.FMayActive3.SpecialReward.length)
         {
            if(this.FMayActive3.SpecialReward[_loc2_].Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_3_ID,TProcessorMayActive.ACTIVITY_3_GET_SPECIAL_REWARD);
            }
         }
      }
      
      protected function ProcessorOnBossOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FMayActive3))
         {
            FOnShowHtmlTip(this.FMayActive3.DescListNew[21]);
         }
      }
      
      protected function ProcessorOnBossOut(param1:MouseEvent) : void
      {
         if(this.FMayActive3)
         {
            if(this.FMayActive3.BossIsAppear == 0 || this.FMayActive3.CurBoss.Min <= 0)
            {
               FMC_Scene.BTN_Boss.MC_Shine.gotoAndStop(1);
            }
            else
            {
               FMC_Scene.BTN_Boss.MC_Shine.gotoAndPlay(1);
            }
            FOnHideHtmlTip();
         }
      }
      
      protected function ProcessorOnHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnShowRecruit != null) && Boolean(this.FMayActive3) && _loc3_ < this.FMayActive3.SpecialReward.length)
         {
            _loc2_ = uint(this.FMayActive3.SpecialReward[_loc3_].Identify);
            FOnShowRecruit(_loc2_,this.FMayActive3.SpecialReward[_loc3_].Type);
         }
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FMayActive3) && _loc3_ < this.FMayActive3.SpecialReward.length)
         {
            this.FHeroList[_loc3_].MC_Hero.filters = [TGameUtil.highLightFilters];
            _loc2_ = this.FMayActive3.SpecialReward[_loc3_];
            if(_loc2_.Type == TBaseBox.TYPE_IS_ITEM)
            {
               FOnItemOver(this,this.FMayActive3.SpecialReward[_loc3_].Inventories.GetInventoryByIndex(0));
            }
            else
            {
               FOnShowHtmlTip(_loc2_.Desc1);
            }
         }
      }
      
      protected function ProcessorOnHeroOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnHideHtmlTip != null)
         {
            this.FHeroList[_loc2_].MC_Hero.filters = [];
            _loc3_ = this.FMayActive3.SpecialReward[_loc2_];
            if(_loc3_.Type == TBaseBox.TYPE_IS_ITEM)
            {
               FOnItemOut(this,this.FMayActive3.SpecialReward[_loc2_].Inventories.GetInventoryByIndex(0));
            }
            else
            {
               FOnHideHtmlTip();
            }
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(FOnItemOver != null) && Boolean(this.FMayActive3) && _loc2_ < this.FMayActive3.BoxList.length)
         {
            FOnItemOver(this,this.FMayActive3.BoxList[_loc2_].Inventories.GetInventoryByIndex(0));
         }
      }
      
      override protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(FOnItemOut != null) && Boolean(this.FMayActive3) && _loc2_ < this.FMayActive3.BoxList.length)
         {
            FOnItemOut(this,this.FMayActive3.BoxList[_loc2_].Inventories.GetInventoryByIndex(0));
         }
      }
      
      protected function ProcessorOnKillGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(11));
         if(Boolean(FOnItemOver != null) && Boolean(this.FMayActive3) && _loc2_ < this.FMayActive3.KillReward.length)
         {
            FOnItemOver(this,this.FMayActive3.KillReward[_loc2_].Inventories.GetInventoryByIndex(0));
         }
      }
      
      protected function ProcessorOnKillGiftOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(11));
         if(Boolean(FOnItemOut != null) && Boolean(this.FMayActive3) && _loc2_ < this.FMayActive3.KillReward.length)
         {
            FOnItemOut(this,this.FMayActive3.KillReward[_loc2_].Inventories.GetInventoryByIndex(0));
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(FOnItemOver != null) && Boolean(this.FMayActive3) && _loc2_ < this.FMayActive3.GiftList.length)
         {
            FOnItemOver(this,this.FMayActive3.GiftList[_loc2_].Inventories.GetInventoryByIndex(0));
         }
      }
      
      protected function ProcessorOnGiftOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(FOnItemOut != null) && Boolean(this.FMayActive3) && _loc2_ < this.FMayActive3.GiftList.length)
         {
            FOnItemOut(this,this.FMayActive3.GiftList[_loc2_].Inventories.GetInventoryByIndex(0));
         }
      }
      
      protected function ProcessorOnSoldierOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(10));
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FMayActive3) && _loc2_ < this.FMayActive3.SoldierList.length)
         {
            FOnShowHtmlTip(this.FMayActive3.SoldierList[_loc2_].Desc1);
         }
      }
      
      protected function ProcessorOnMySoldierOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         if(FOnShowHtmlTip != null && Boolean(this.FMayActive3))
         {
            _loc2_ = this.FMayActive3.MySoldier.Type;
            if(_loc2_ == 0)
            {
               FOnShowHtmlTip(this.FMayActive3.DescListNew[13]);
            }
            else
            {
               FOnShowHtmlTip(this.FMayActive3.SoldierList[_loc2_ - 1].Desc2);
            }
         }
      }
      
      protected function ProcessorOnAttackOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         if(FOnShowHtmlTip != null && Boolean(this.FMayActive3))
         {
            FOnShowHtmlTip(this.FMayActive3.DescListNew[24]);
         }
      }
      
      protected function ProcessorOnGoOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         if(FOnShowHtmlTip != null && Boolean(this.FMayActive3))
         {
            FOnShowHtmlTip(this.FMayActive3.DescListNew[23]);
         }
      }
      
      protected function ProcessorOnPowerOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         if(FOnShowHtmlTip != null && Boolean(this.FMayActive3))
         {
            FOnShowHtmlTip(this.FMayActive3.DescListNew[25]);
         }
      }
      
      protected function ProcessorOnBossTipOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         if(FOnShowHtmlTip != null && Boolean(this.FMayActive3))
         {
            if(this.FIsShowBoss)
            {
               FOnShowHtmlTip(this.FMayActive3.MonsterDesc[this.FMayActive3.CurBoss.Type - 1]);
            }
            else
            {
               FOnShowHtmlTip(this.FMayActive3.MonsterDesc[this.FMayActive3.CurMonster.Type - 1]);
            }
         }
      }
      
      protected function ProcessorOnAddAPOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         if(FOnShowHtmlTip != null && Boolean(this.FMayActive3))
         {
            FOnShowHtmlTip(this.FMayActive3.DescListNew[14]);
         }
      }
      
      protected function ProcessorOnAddMpOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         if(FOnShowHtmlTip != null && Boolean(this.FMayActive3))
         {
            FOnShowHtmlTip(this.FMayActive3.DescListNew[15]);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(this,param2);
         }
      }
      
      protected function ProcessorOnLogUp(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_3_ID);
         }
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         if(FOnLoadRank != null)
         {
            FOnLoadRank(ACTIVITY_3_ID);
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         if(FInitialized && this.visible)
         {
            if(this.FMayActive3)
            {
               this.UpdataBitmap();
               if(this.FTF_SoldierTime)
               {
                  if(this.FMayActive3.MySoldier.Type != 0)
                  {
                     if(this.FMayActive3.MySoldier.Time <= STimingCore.GetServerTick())
                     {
                        this.FMayActive3.SoldierList[this.FMayActive3.MySoldier.Type - 1].Status = TBaseActivity.STATUS_CANNOTGET;
                        this.FMayActive3.MySoldier.Type = 0;
                        this.FMayActive3.MySoldier.Level = 0;
                        this.FMayActive3.MySoldier.Time = 0;
                        this.UpdateSoldier();
                     }
                     else
                     {
                        this.FTF_SoldierTime.text = TUtilityString.Format(this.FMayActive3.DescListNew[2],TGameUtil.fomatTime(this.FMayActive3.MySoldier.Time - STimingCore.GetServerTick()));
                     }
                  }
               }
            }
            if(FIsPlaying)
            {
               if(this.FMovieType == MOVIE_GOTO_NEW_MAP)
               {
                  CurFrame = FMC_Scene.MC_Map.MC_MapEffect.currentFrame;
               }
               else if(this.FMovieType == MOVIE_REFRESH_MONSTER)
               {
                  CurFrame = FMC_Scene.MC_Boss.MC_RefreshMovie.currentFrame;
               }
               else if(this.FMovieType == MOVIE_TYPE_BEAT_MONSTER)
               {
                  CurFrame = FMC_Scene.MC_Boss.MC_BeatMovie.currentFrame;
               }
               else if(this.FMovieType == MOVIE_TYPE_BEAT_BOSS)
               {
                  CurFrame = FMC_Scene.MC_Boss.MC_BeatMovie.currentFrame;
               }
               else if(this.FMovieType == MOVIE_DROP_BOX)
               {
                  CurFrame = FMC_Scene.MC_GiftEffect.MC_Icon.currentFrame;
               }
               if(CurFrame >= FTotalFrame)
               {
                  FIsPlaying = false;
                  this.MovieEnd();
               }
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FIsWaiting = false;
         this.FMayActive3 = SLogicsCore.MayActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TMayActive3;
         this.UpdateSoldier();
         this.UpdateMonster();
         this.UpdateHero();
         this.UpdateBox();
         this.UpdateText();
         this.SetInterval();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         FIsPlaying = true;
         this.FMovieType = param1;
         if(this.FMovieType == MOVIE_GOTO_NEW_MAP)
         {
            _loc5_ = FMC_Scene.MC_Map.MC_MapEffect;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_REFRESH_MONSTER)
         {
            FMC_Scene.MC_Boss.visible = true;
            _loc5_ = FMC_Scene.MC_Boss.MC_RefreshMovie;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.visible = true;
            _loc5_.gotoAndPlay(1);
            FMC_Scene.MC_Boss.MC_BeatMovie.visible = false;
            FMC_Scene.MC_Boss.MC_KillMovie.gotoAndStop(this.FMayActive3.CurMonster.Type * 2 - 1);
         }
         else if(this.FMovieType == MOVIE_TYPE_BEAT_MONSTER)
         {
            _loc5_ = FMC_Scene.MC_Boss.MC_BeatMovie;
            _loc5_.visible = true;
            FMC_Scene.MC_Boss.MC_BeatMovie.MC_BossIcon.gotoAndStop(this.FMayActive3.CurMonster.Type);
            FMC_Scene.MC_Boss.MC_KillMovie.visible = false;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_TYPE_BEAT_BOSS)
         {
            _loc5_ = FMC_Scene.MC_Boss.MC_BeatMovie;
            _loc5_.visible = true;
            FMC_Scene.MC_Boss.MC_BeatMovie.MC_BossIcon.gotoAndStop(this.FMayActive3.CurBoss.Type);
            FMC_Scene.MC_Boss.MC_KillMovie.visible = false;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_DROP_BOX)
         {
            FMC_Scene.MC_GiftEffect.visible = true;
            FMC_Scene.MC_GiftEffect.gotoAndStop(this.FDropBoxIndex + 1);
            _loc5_ = FMC_Scene.MC_GiftEffect.MC_Icon;
            _loc5_.visible = true;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:String = null;
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         if(this.FMovieType == MOVIE_GOTO_NEW_MAP)
         {
            FMC_Scene.MC_Map.MC_MapEffect.gotoAndStop(1);
            if(this.FMayActive3.CurMonster.Type == 0)
            {
               if(this.FDropBoxIndex != -1)
               {
                  this.PlayMovie(MOVIE_DROP_BOX);
               }
               else
               {
                  this.UpdateUI();
               }
            }
            else
            {
               this.PlayMovie(MOVIE_REFRESH_MONSTER);
            }
         }
         else if(this.FMovieType == MOVIE_REFRESH_MONSTER)
         {
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_TYPE_BEAT_BOSS)
         {
            FMC_Scene.MC_Boss.MC_BeatMovie.visible = false;
            FMC_Scene.MC_Boss.MC_KillMovie.visible = true;
            if(this.FMayActive3.CurBoss.Min <= 0)
            {
               FMC_Scene.MC_Boss.MC_KillMovie.gotoAndStop(this.FMayActive3.CurBoss.Type * 2);
               FMC_Scene.MC_Boss.MC_Bar.TF_Count.text = 0 + "/" + this.FMayActive3.CurBoss.Max;
               TweenUtil.to(this.FMC_Mask,1000,{"width":0});
               if(this.FDropBoxIndex != -1)
               {
                  this.PlayMovie(MOVIE_DROP_BOX);
               }
               else
               {
                  this.FIsWaiting = true;
                  setTimeout(this.UpdateUI,1000);
               }
            }
            else
            {
               this.UpdateUI();
            }
         }
         else if(this.FMovieType == MOVIE_TYPE_BEAT_MONSTER)
         {
            FMC_Scene.MC_Boss.MC_BeatMovie.visible = false;
            FMC_Scene.MC_Boss.MC_KillMovie.visible = true;
            if(this.FMayActive3.CurMonster.Min <= 0)
            {
               FMC_Scene.MC_Boss.MC_KillMovie.gotoAndStop(this.FMayActive3.CurMonster.Type * 2);
               FMC_Scene.MC_Boss.MC_Bar.TF_Count.text = 0 + "/" + this.FMayActive3.CurMonster.Max;
               TweenUtil.to(this.FMC_Mask,1000,{"width":0});
               if(this.FDropBoxIndex != -1)
               {
                  this.PlayMovie(MOVIE_DROP_BOX);
               }
               else
               {
                  this.FIsWaiting = true;
                  setTimeout(this.UpdateUI,1000);
               }
            }
            else
            {
               this.UpdateUI();
            }
         }
         else if(this.FMovieType == MOVIE_DROP_BOX)
         {
            FMC_Scene.MC_GiftEffect.visible = false;
            this.UpdateUI();
         }
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         this.FDropBoxIndex = param1;
      }
      
      override public function Unmount() : void
      {
         if(this.FBossHpTimeID != 0)
         {
            clearTimeout(this.FBossHpTimeID);
            this.FBossHpTimeID = 0;
         }
      }
   }
}

