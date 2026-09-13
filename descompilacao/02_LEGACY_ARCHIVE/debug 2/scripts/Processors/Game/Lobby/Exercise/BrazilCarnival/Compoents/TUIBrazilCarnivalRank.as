package Processors.Game.Lobby.Exercise.BrazilCarnival.Compoents
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.BrazilCarnival.TBrazilCarnivalRank;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BrazilCarnival.TProcessorBrazilCarnival;
   import Processors.Game.Lobby.Exercise.Christmas.Compoents.TUIChristmasBase;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIBrazilCarnivalRank extends TUIChristmasBase
   {
      
      protected static const BOX_COUNT:int = 5;
      
      protected static const HERO_COUNT:int = 2;
      
      protected static const ACTIVITY_3_ID:int = 3;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FHeroList:Vector.<MovieClip>;
      
      protected var FBrazilCarnivalRank:TBrazilCarnivalRank;
      
      public function TUIBrazilCarnivalRank(param1:TUIComponent)
      {
         super(param1);
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FHeroList = new Vector.<MovieClip>(HERO_COUNT);
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
            this.FBoxList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBoxUp);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < HERO_COUNT)
         {
            this.FHeroList[_loc2_] = FMC_Scene["MC_Hero" + _loc2_];
            this.FHeroList[_loc2_].buttonMode = true;
            if(this.FHeroList[_loc2_].MC_Tips)
            {
               this.FHeroList[_loc2_].MC_Tips.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroUp);
               this.FHeroList[_loc2_].MC_Tips.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
               this.FHeroList[_loc2_].MC_Tips.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnHeroOut);
            }
            else
            {
               this.FHeroList[_loc2_].MC_Hero.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroUp);
               this.FHeroList[_loc2_].MC_Hero.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
               this.FHeroList[_loc2_].MC_Hero.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnHeroOut);
            }
            TGameUtil.setButtonMode(this.FHeroList[_loc2_].Btn_Get,true);
            this.FHeroList[_loc2_].Btn_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetHeroUp);
            _loc2_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.Btn_Rank,true);
         FMC_Scene.Btn_Rank.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadRank);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FBoxList[_loc1_];
            if(this.FBrazilCarnivalRank.BoxList[_loc1_])
            {
               _loc3_.TF_Count.text = "*" + this.FBrazilCarnivalRank.BoxList[_loc1_].Price;
               _loc3_.MC_BoxPic.MC_Icon.gotoAndStop(_loc1_ + 1);
               if(this.FBrazilCarnivalRank.BoxList[_loc1_].Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc3_.MC_CanGet.visible = true;
                  _loc3_.MC_BoxPic.gotoAndPlay(1);
               }
               else if(this.FBrazilCarnivalRank.BoxList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET)
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
         _loc1_ = 0;
         while(_loc1_ < HERO_COUNT)
         {
            _loc3_ = this.FHeroList[_loc1_];
            if(this.FBrazilCarnivalRank.HeroList[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               _loc3_.MC_Got.visible = false;
               _loc3_.Btn_Get.visible = true;
            }
            else if(this.FBrazilCarnivalRank.HeroList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc3_.MC_Got.visible = false;
               _loc3_.Btn_Get.visible = false;
            }
            else
            {
               _loc3_.MC_Got.visible = true;
               _loc3_.Btn_Get.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FBrazilCarnivalRank.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FBrazilCarnivalRank.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Count.text = "*" + this.FBrazilCarnivalRank.Score.toString();
      }
      
      override protected function ProcessorOnCollectUp(param1:MouseEvent) : void
      {
         if(FOnCollectUp != null)
         {
            FOnCollectUp();
         }
      }
      
      override protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(FOnGetBox != null)
         {
            _loc2_ = int(String(param1.currentTarget.name).slice(6));
            if(this.FBrazilCarnivalRank.BoxList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_3_ID,TProcessorBrazilCarnival.BrazilCarnival_RANK_GET_BOX,_loc2_ + 1);
            }
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.name).slice(6));
         if(FOnItemOver != null && Boolean(this.FBrazilCarnivalRank.BoxList[_loc3_]))
         {
            _loc2_ = this.FBrazilCarnivalRank.BoxList[_loc3_].Inventories.GetInventoryByIndex(0);
            FOnItemOver(this,_loc2_);
         }
      }
      
      override protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.name).slice(6));
         if(FOnItemOut != null && this.FBrazilCarnivalRank.BoxList[_loc3_].Inventories.Count > 0)
         {
            _loc2_ = this.FBrazilCarnivalRank.BoxList[_loc3_].Inventories.GetInventoryByIndex(0);
            FOnItemOut(this,_loc2_);
         }
      }
      
      protected function ProcessorOnGetHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(FOnGetBox != null)
         {
            _loc2_ = int(String(param1.currentTarget.name).slice(7));
            if(this.FBrazilCarnivalRank.HeroList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_3_ID,TProcessorBrazilCarnival.BrazilCarnival_RANK_GET_HERO);
            }
         }
      }
      
      protected function ProcessorOnHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(_loc3_ <= this.FBrazilCarnivalRank.HeroList.length && this.FBrazilCarnivalRank.HeroList[_loc3_].Type == TBaseBox.TYPE_IS_HERO && FOnShowRecruit != null)
         {
            _loc3_ = int(String(param1.currentTarget.parent.name).slice(7));
            _loc2_ = uint(this.FBrazilCarnivalRank.HeroList[_loc3_].Identify);
            FOnShowRecruit(_loc2_);
         }
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         var _loc3_:int = 0;
         if(FOnShowHeroTip != null)
         {
            _loc3_ = int(String(param1.currentTarget.parent.name).slice(7));
            if(this.FBrazilCarnivalRank.HeroList[_loc3_])
            {
               this.FHeroList[_loc3_].MC_Hero.filters = [TGameUtil.highLightFilters];
               _loc2_ = this.FBrazilCarnivalRank.HeroList[_loc3_];
               FOnShowHeroTip(_loc2_);
            }
         }
      }
      
      protected function ProcessorOnHeroOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(FOnHideHeroTip != null)
         {
            _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
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
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         if(FInitialized && this.visible)
         {
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FBrazilCarnivalRank = SLogicsCore.BrazilCarnivalDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TBrazilCarnivalRank;
         this.UpdateBox();
         this.UpdateHero();
         this.UpdateText();
      }
   }
}

