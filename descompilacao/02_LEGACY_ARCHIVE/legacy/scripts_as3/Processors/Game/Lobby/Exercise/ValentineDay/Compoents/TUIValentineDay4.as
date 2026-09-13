package Processors.Game.Lobby.Exercise.ValentineDay.Compoents
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TActivityPetConfig;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Exercise.ValentineDay.TValentineDay4;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.ValentineDay.TProcessorValentineDay;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIValentineDay4 extends TUIBaseWindow
   {
      
      public static const BOX_COUNT:uint = 5;
      
      public static const PET_COUNT:uint = 3;
      
      public static const CHANGE_CHIP_COUNT:int = 0;
      
      public static const CHANGE_BOX_STATUS:int = 1;
      
      public static const CHANGE_PET_STATUS:int = 2;
      
      public static const ACTIVITY_4_ID:int = 4;
      
      protected var FSpriteVect:Vector.<MovieClip>;
      
      protected var FBoxVect:Vector.<MovieClip>;
      
      protected var FTF_FreeCount:TextField;
      
      protected var FSelectedIndex:int;
      
      protected var FValentineDay4:TValentineDay4;
      
      protected var FMovieIndex:int;
      
      public function TUIValentineDay4(param1:TUIComponent)
      {
         super(param1);
         this.FSpriteVect = new Vector.<MovieClip>(BOX_COUNT);
         this.FBoxVect = new Vector.<MovieClip>(BOX_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            param1 = FMC_Scene["MC_Sprite" + _loc2_];
            param1.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSpriteOver);
            param1.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnSpriteOut);
            this.FSpriteVect[_loc2_] = param1;
            param1 = FMC_Scene["MC_Box" + _loc2_];
            param1.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            param1.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            param1.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyBoxUp);
            this.FBoxVect[_loc2_] = param1;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < PET_COUNT)
         {
            FMC_Scene["MC_Pet" + _loc2_].buttonMode = true;
            FMC_Scene["MC_Pet" + _loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnPetUp);
            FMC_Scene["MC_Pet" + _loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnPetOver);
            FMC_Scene["MC_Pet" + _loc2_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnPetOut);
            _loc2_++;
         }
         this.FTF_FreeCount = FMC_Scene.TF_FreeCount;
         FMC_Scene.MC_Title.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTitleOver);
         FMC_Scene.MC_Title.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnTitleOut);
         FMC_Scene.MC_PetTip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnPetTipOver);
         FMC_Scene.MC_PetTip.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnPetTipOut);
         FMC_Scene.BTN_ShowRecruit.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowRecruit);
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FValentineDay4.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FValentineDay4.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FValentineDay4.ActivityDesc;
         this.FTF_FreeCount.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_FREE_LIMIT_TIMES,this.FValentineDay4.FreeTimes);
      }
      
      protected function UpdateSprite() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc2_ = this.FSpriteVect[_loc1_];
            _loc2_.MC_Icon.gotoAndStop(_loc1_ + 1);
            _loc2_.TF_Count.text = this.FValentineDay4.ExchangeInventories.GetInventoryByIndex(_loc1_).Quantity;
            _loc1_++;
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc2_ = this.FBoxVect[_loc1_];
            if(this.FValentineDay4.BoxVect[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc2_.MC_Lock.visible = true;
               TGameUtil.setButtonMode(_loc2_.BTN_Buy,false);
            }
            else
            {
               _loc2_.MC_Lock.visible = false;
               TGameUtil.setButtonMode(_loc2_.BTN_Buy,true);
            }
            _loc2_.MC_Icon.gotoAndStop(_loc1_ + 1);
            _loc2_.TF_Round.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ROUND_COUNT,_loc1_ + 1);
            _loc1_++;
         }
      }
      
      protected function UpdatePet() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:uint = 0;
         var _loc6_:TActivityPetConfig = null;
         _loc1_ = 0;
         while(_loc1_ < PET_COUNT)
         {
            if(this.FValentineDay4.PetVect[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               FMC_Scene["MC_Pet" + _loc1_].gotoAndPlay(1);
               FMC_Scene["MC_Pet" + _loc1_].MC_Got.visible = false;
               FMC_Scene["MC_Pet" + _loc1_].Btn_GetReward.visible = true;
            }
            else if(this.FValentineDay4.PetVect[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET)
            {
               FMC_Scene["MC_Pet" + _loc1_].gotoAndStop(1);
               FMC_Scene["MC_Pet" + _loc1_].MC_Got.visible = false;
               FMC_Scene["MC_Pet" + _loc1_].Btn_GetReward.visible = false;
            }
            else
            {
               FMC_Scene["MC_Pet" + _loc1_].gotoAndStop(1);
               FMC_Scene["MC_Pet" + _loc1_].MC_Got.visible = true;
               FMC_Scene["MC_Pet" + _loc1_].Btn_GetReward.visible = false;
            }
            FMC_Scene["MC_Pet" + _loc1_].MC_Pet.gotoAndStop(_loc1_ + 1);
            _loc1_++;
         }
      }
      
      protected function ProcessorOnBuyBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(!param1.currentTarget.buttonMode || !this.FValentineDay4 || _loc2_ >= this.FValentineDay4.BoxVect.length)
         {
            return;
         }
         this.FMovieIndex = _loc2_;
         if(FOnBuyBox != null)
         {
            if(this.FValentineDay4.FreeTimes > 0)
            {
               FOnBuyBox(ACTIVITY_4_ID,TProcessorValentineDay.ACTIVITY_4_BUY_BOX,0,_loc2_ + 1,TBaseActivity.SWEET_TYPE_FREE);
            }
            else
            {
               FOnBuyBox(ACTIVITY_4_ID,TProcessorValentineDay.ACTIVITY_4_BUY_BOX,this.FValentineDay4.BoxVect[_loc2_].Price,_loc2_ + 1,TBaseActivity.SWEET_TYPE_GOLD);
            }
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(this.FValentineDay4) && _loc2_ < this.FValentineDay4.BoxVect.length)
         {
            _loc4_ = this.FValentineDay4.BoxVect[_loc2_];
            if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               FOnShowTip(_loc4_.Desc4);
            }
            else
            {
               FOnShowThreeStr(this.FValentineDay4.BoxVect[_loc2_]);
            }
         }
      }
      
      override protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(this.FValentineDay4) && _loc2_ < this.FValentineDay4.BoxVect.length)
         {
            _loc4_ = this.FValentineDay4.BoxVect[_loc2_];
            if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               FOnHideTip();
            }
            else
            {
               FOnHideThreeStr();
            }
         }
      }
      
      protected function ProcessorOnPetUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc2_ = int(param1.currentTarget.name.slice(6));
         if(Boolean(FOnGetBox != null && this.FValentineDay4) && Boolean(_loc2_ < this.FValentineDay4.PetVect.length) && this.FValentineDay4.PetVect[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_4_ID,TProcessorValentineDay.ACTIVITY_4_GET_PET,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnPetOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TActivityPetConfig = null;
         _loc2_ = int(param1.currentTarget.name.slice(6));
         if(Boolean(FOnShowHeroTip != null) && Boolean(this.FValentineDay4) && _loc2_ < this.FValentineDay4.PetVect.length)
         {
            FOnShowHeroTip(this.FValentineDay4.PetVect[_loc2_]);
         }
      }
      
      protected function ProcessorOnPetOut(param1:MouseEvent) : void
      {
         if(FOnHideHeroTip != null)
         {
            FOnHideHeroTip();
         }
      }
      
      protected function ProcessorOnSpriteOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc2_ = int(param1.currentTarget.name.slice(9));
         if(Boolean(FOnShowTip != null) && Boolean(this.FValentineDay4) && Boolean(this.FValentineDay4.ExchangeInventories))
         {
            _loc3_ = this.FValentineDay4.ExchangeInventories.GetInventoryByIndex(_loc2_).Name;
            FOnShowTip(_loc3_);
         }
      }
      
      protected function ProcessorOnSpriteOut(param1:MouseEvent) : void
      {
         if(FOnHideTip != null)
         {
            FOnHideTip();
         }
      }
      
      protected function ProcessorOnTitleOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowTitleTip != null) && Boolean(this.FValentineDay4) && Boolean(this.FValentineDay4.TitleID))
         {
            FOnShowTitleTip(this.FValentineDay4.TitleID);
         }
      }
      
      protected function ProcessorOnTitleOut(param1:MouseEvent) : void
      {
         if(FOnHideTitleTip != null)
         {
            FOnHideTitleTip();
         }
      }
      
      protected function ProcessorOnPetTipOver(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(Boolean(FOnShowTitleTip != null) && Boolean(this.FValentineDay4) && Boolean(this.FValentineDay4.TitleID))
         {
            _loc2_ = new TBaseBox();
            _loc2_.Desc1 = this.FValentineDay4.ActivityDesc2;
            _loc2_.Desc2 = this.FValentineDay4.ActivityDesc3;
            _loc2_.Desc3 = this.FValentineDay4.ActivityName;
            FOnShowThreeStr(_loc2_);
         }
      }
      
      protected function ProcessorOnPetTipOut(param1:MouseEvent) : void
      {
         if(FOnHideThreeStr != null)
         {
            FOnHideThreeStr();
         }
      }
      
      protected function ProcessorOnShowRecruit(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:TConfigValue = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60380131) as TConfigValue;
         _loc3_ = _loc2_.Value as int;
         if(FOnShowRecruit != null)
         {
            FOnShowRecruit(_loc3_);
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
            if(FIsPlaying)
            {
               CurFrame = this.FBoxVect[this.FMovieIndex].MC_Icon["MC_Icon" + this.FMovieIndex].currentFrame;
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
         this.FValentineDay4 = SLogicsCore.ValentineDayDatas.GetActivityByIdentify(ACTIVITY_4_ID) as TValentineDay4;
         this.UpdateText();
         this.UpdateSprite();
         this.UpdateBox();
         this.UpdatePet();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:TInventories = null;
         FIsPlaying = true;
         _loc3_ = this.FBoxVect[this.FMovieIndex].MC_Icon["MC_Icon" + this.FMovieIndex];
         FTotalFrame = _loc3_.totalFrames;
         _loc3_.gotoAndPlay(1);
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         _loc3_ = this.FBoxVect[this.FMovieIndex].MC_Icon["MC_Icon" + this.FMovieIndex];
         FTotalFrame = _loc3_.totalFrames;
         _loc3_.gotoAndStop(1);
         this.UpdateUI();
      }
   }
}

