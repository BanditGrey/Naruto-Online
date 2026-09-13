package Processors.Game.Lobby.Exercise.NinjaTreasure.Compoents
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
   import Logics.Exercise.NinjaTreasure.TNinjaTreasure5;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.JuneActive.TProcessorJuneActive;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   
   public class TUINinjaTreasure5 extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 5;
      
      protected static const HERO_COUNT:int = 2;
      
      protected static const ACTIVITY_3_ID:int = 3;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FHeroList:Vector.<MovieClip>;
      
      protected var FHeadBitmapVect:Vector.<Bitmap>;
      
      protected var FHeadIconList:Vector.<uint>;
      
      protected var FHeadIconType:Vector.<int>;
      
      protected var FNinjaTreasure5:TNinjaTreasure5;
      
      protected var FTextFormat:TextFormat;
      
      public function TUINinjaTreasure5(param1:TUIComponent)
      {
         super(param1);
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FHeroList = new Vector.<MovieClip>(HERO_COUNT);
         this.FHeadBitmapVect = new Vector.<Bitmap>(HERO_COUNT);
         this.FHeadIconList = new Vector.<uint>(HERO_COUNT);
         this.FHeadIconType = new Vector.<int>(HERO_COUNT);
         this.FTextFormat = new TextFormat();
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            this.FBoxList[_loc2_] = FMC_Scene["MC_Box" + _loc2_];
            this.FBoxList[_loc2_].MC_BoxPic.buttonMode = true;
            this.FBoxList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBoxUp);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < HERO_COUNT)
         {
            this.FHeroList[_loc2_] = FMC_Scene["MC_Hero" + _loc2_];
            this.FHeroList[_loc2_].MC_Tip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
            this.FHeroList[_loc2_].MC_Tip.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnHeroOut);
            TGameUtil.setButtonMode(this.FHeroList[_loc2_].Btn_Get,true);
            this.FHeroList[_loc2_].Btn_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetHeroUp);
            TGameUtil.setButtonMode(this.FHeroList[_loc2_].Btn_Recruit,true);
            this.FHeroList[_loc2_].Btn_Recruit.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroUp);
            this.FHeadBitmapVect[_loc2_] = new Bitmap();
            this.FHeroList[_loc2_].MC_Hero.addChild(this.FHeadBitmapVect[_loc2_]);
            _loc2_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.Btn_Rank,true);
         FMC_Scene.Btn_Rank.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadRank);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         FMC_Scene.MC_Drum.buttonMode = true;
         FMC_Scene.MC_Drum.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTaikoOver);
         FMC_Scene.MC_Drum.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnTaikoOut);
         FMC_Scene.MC_Stick.buttonMode = true;
         FMC_Scene.MC_Stick.addEventListener(MouseEvent.CLICK,this.ProcessorOnClickTaiko);
         if(FMC_Scene.BTN_Log)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
            FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
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
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FBoxList[_loc1_];
            if(_loc1_ < this.FNinjaTreasure5.BoxList.length)
            {
               _loc4_ = this.FNinjaTreasure5.BoxList[_loc1_];
               _loc5_ = this.FNinjaTreasure5.BoxList[this.FNinjaTreasure5.BoxList.length - 1];
               _loc3_.MC_Count.TF_Count.text = "*" + (_loc4_.Price + (this.FNinjaTreasure5.Round - 1) * _loc5_.Price);
               _loc3_.MC_BoxPic.MC_Icon.gotoAndStop(_loc1_ + 1);
               if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc3_.MC_CanGet.visible = true;
                  _loc3_.MC_BoxPic.gotoAndPlay(1);
               }
               else if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc3_.MC_CanGet.visible = false;
                  _loc3_.MC_BoxPic.gotoAndStop(1);
               }
            }
            _loc1_++;
         }
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
            if(_loc1_ < this.FNinjaTreasure5.HeroList.length)
            {
               _loc4_ = this.FNinjaTreasure5.HeroList[_loc1_];
               _loc3_.MC_Tip.gotoAndPlay(1);
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
      
      public function UpdataBitmap() : void
      {
         var _loc1_:int = 0;
         if(Boolean(this.FNinjaTreasure5) && Boolean(this.FNinjaTreasure5.HeroList.length > 0) && Boolean(this.FHeroList[0]))
         {
            _loc1_ = 0;
            while(_loc1_ < HERO_COUNT)
            {
               if(this.FHeadIconType[_loc1_] >= 0)
               {
                  this.FHeroList[_loc1_].MC_Hero.x = 13 + (89 - this.FHeadBitmapVect[_loc1_].width) / 2;
                  this.FHeroList[_loc1_].MC_Hero.y = 13 + (79 - this.FHeadBitmapVect[_loc1_].height) / 2;
                  TGameUtil.ShowImageByID(this.FHeadIconType[_loc1_],this.FHeadBitmapVect[_loc1_],CONST_MODULES.ACTIVE_Test,this.FHeadIconList[_loc1_]);
               }
               _loc1_++;
            }
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FNinjaTreasure5.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FNinjaTreasure5.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Times.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_AMOUNT,this.FNinjaTreasure5.Count);
         FMC_Scene.TF_Count.text = "*" + this.FNinjaTreasure5.RankPoint;
         FMC_Scene.TF_Desc.text = this.FNinjaTreasure5.ActivityName;
      }
      
      protected function ProcessorOnClickTaiko(param1:MouseEvent) : void
      {
         if(FIsPlaying)
         {
            FOnShowFlowText(STRING_BASEACTIVITY.FORMAT_WAIT_AMOUNT);
            return;
         }
         if(FOnBuyBox != null && Boolean(this.FNinjaTreasure5))
         {
            if(this.FNinjaTreasure5.Count > 0)
            {
               FOnBuyBox(ACTIVITY_3_ID,TProcessorJuneActive.ACTIVITY_3_BUY_BOX,this.FNinjaTreasure5.Cost,0,TBaseActivity.SWEET_TYPE_FREE);
            }
            else
            {
               FOnBuyBox(ACTIVITY_3_ID,TProcessorJuneActive.ACTIVITY_3_BUY_BOX,this.FNinjaTreasure5.Cost,0,TBaseActivity.SWEET_TYPE_GOLD);
            }
         }
      }
      
      protected function ProcessorOnTaikoOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null)
         {
            FOnShowHtmlTip(this.FNinjaTreasure5.ActivityDesc2);
         }
      }
      
      protected function ProcessorOnTaikoOut(param1:MouseEvent) : void
      {
         if(FOnHideHtmlTip != null)
         {
            FOnHideHtmlTip();
         }
      }
      
      override protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnGetBox != null) && Boolean(this.FNinjaTreasure5) && _loc2_ < this.FNinjaTreasure5.BoxList.length)
         {
            if(this.FNinjaTreasure5.BoxList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_3_ID,TProcessorJuneActive.ACTIVITY_3_GET_BOX,_loc2_ + 1);
            }
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnItemOver != null) && Boolean(this.FNinjaTreasure5) && _loc3_ < this.FNinjaTreasure5.BoxList.length)
         {
            _loc2_ = this.FNinjaTreasure5.BoxList[_loc3_].Inventories.GetInventoryByIndex(0);
            FOnItemOver(this,_loc2_);
         }
      }
      
      override protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnItemOut != null) && Boolean(this.FNinjaTreasure5) && _loc3_ < this.FNinjaTreasure5.BoxList.length)
         {
            _loc2_ = this.FNinjaTreasure5.BoxList[_loc3_].Inventories.GetInventoryByIndex(0);
            FOnItemOut(this,_loc2_);
         }
      }
      
      protected function ProcessorOnGetHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(FOnGetBox != null) && Boolean(this.FNinjaTreasure5) && _loc2_ < this.FNinjaTreasure5.HeroList.length)
         {
            if(this.FNinjaTreasure5.HeroList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_3_ID,TProcessorJuneActive.ACTIVITY_3_GET_HERO);
            }
         }
      }
      
      protected function ProcessorOnHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnShowRecruit != null) && Boolean(this.FNinjaTreasure5) && _loc3_ < this.FNinjaTreasure5.HeroList.length)
         {
            _loc2_ = uint(this.FNinjaTreasure5.HeroList[_loc3_].Identify);
            FOnShowRecruit(_loc2_,this.FNinjaTreasure5.HeroList[_loc3_].Type);
         }
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnShowHeroTip != null) && Boolean(this.FNinjaTreasure5) && _loc3_ < this.FNinjaTreasure5.HeroList.length)
         {
            this.FHeroList[_loc3_].MC_Hero.filters = [TGameUtil.highLightFilters];
            _loc2_ = this.FNinjaTreasure5.HeroList[_loc3_];
            FOnShowHeroTip(_loc2_);
         }
      }
      
      protected function ProcessorOnHeroOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnHideHeroTip != null)
         {
            this.FHeroList[_loc2_].MC_Hero.filters = [];
            FOnHideHeroTip();
         }
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         if(FOnLoadRank != null)
         {
            FOnLoadRank(ACTIVITY_3_ID);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_3_ID);
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         if(FInitialized && this.visible)
         {
            this.UpdataBitmap();
            if(FIsPlaying)
            {
               CurFrame = FMC_Scene.MC_Stick.currentFrame;
               if(CurFrame == FTotalFrame)
               {
                  FIsPlaying = false;
                  this.MovieEnd();
               }
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FNinjaTreasure5 = SLogicsCore.NinjaTreasureDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TNinjaTreasure5;
         this.UpdateBox();
         this.UpdateHero();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:TInventories = null;
         _loc5_ = FMC_Scene.MC_Stick;
         if(_loc5_)
         {
            FIsPlaying = true;
            _loc5_.visible = true;
            FIsMovieVisible = param2;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         FMC_Scene.MC_Stick.gotoAndStop(1);
         FMC_Scene.MC_Stick.visible = FIsMovieVisible;
      }
   }
}

