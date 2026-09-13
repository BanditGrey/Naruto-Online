package Processors.Game.Lobby.NinjaRelationship.Component
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TFetters;
   import Logics.NinjaRelation.TNinjaGroupBuff;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NinjaRelationship;
   import Resources.Strings.STRING_NINJARELATION;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorNewExchangeFream extends TProcessorLobbyWindow
   {
      
      protected var MainPanel:Sprite = null;
      
      protected var DateVec:Vector.<uint> = null;
      
      protected var FCurIndex:int;
      
      protected var FCurCostDian:uint;
      
      protected var FCuraddPro:uint;
      
      protected var FCostCount:int;
      
      protected var count:uint;
      
      protected var FTF_Dec1:TextField = null;
      
      protected var FTF_Dec2:TextField = null;
      
      protected var FMC_BtnLeft:SimpleButton = null;
      
      protected var FMC_BtnRight:SimpleButton = null;
      
      protected var FTF_Num:TextField = null;
      
      protected var FMC_BtnMax:MovieClip = null;
      
      protected var FMC_BtnOk:MovieClip = null;
      
      protected var FMC_BtnCancel:MovieClip = null;
      
      protected var FCurData:TNinjaGroupBuff;
      
      protected var FBackFun:Function = null;
      
      public function TProcessorNewExchangeFream(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_NinjaRelationship.RESOURCE_NINJARELATIONSHIP);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(-(FUICore.StageWidth / 2),-(FUICore.StageHeight / 2),FUICore.StageWidth * 2,FUICore.StageHeight * 2);
         this.graphics.endFill();
         this.MainPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_CostTanKuang") as Sprite;
         addChild(this.MainPanel);
         this.FTF_Dec1 = this.MainPanel["TF_Dec1"];
         this.FTF_Dec2 = this.MainPanel["TF_Dec2"];
         this.FMC_BtnLeft = this.MainPanel["MC_BtnLeft"];
         this.FMC_BtnRight = this.MainPanel["MC_BtnRight"];
         this.FTF_Num = this.MainPanel["TF_Num"];
         this.FMC_BtnMax = this.MainPanel["MC_BtnMax"];
         this.FTF_Num.restrict = "0-9";
         this.FTF_Num.maxChars = 4;
         this.FMC_BtnOk = this.MainPanel["MC_BtnOk"];
         this.FMC_BtnCancel = this.MainPanel["MC_BtnCancel"];
         this.MainPanel.x = (FUICore.StageWidth - this.MainPanel.width) / 2;
         this.MainPanel.y = (FUICore.StageHeight - this.MainPanel.height) / 2;
         this.FMC_BtnOk.addEventListener(MouseEvent.CLICK,this.MouseClick);
         this.FMC_BtnCancel.addEventListener(MouseEvent.CLICK,this.MouseClick);
         this.FMC_BtnLeft.addEventListener(MouseEvent.CLICK,this.MouseClick);
         this.FMC_BtnRight.addEventListener(MouseEvent.CLICK,this.MouseClick);
         this.FMC_BtnMax.addEventListener(MouseEvent.CLICK,this.MouseClick);
         this.FTF_Num.addEventListener(Event.CHANGE,this.OnTextInput);
         TGameUtil.setButtonMode(this.FMC_BtnMax,true);
         TGameUtil.setButtonMode(this.FMC_BtnOk,true);
         TGameUtil.setButtonMode(this.FMC_BtnCancel,true);
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function MouseClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_BtnLeft:
               --this.FCostCount;
               this.UpdateView();
               break;
            case this.FMC_BtnRight:
               ++this.FCostCount;
               this.UpdateView();
               break;
            case this.FMC_BtnMax:
               this.UpdateView(1);
               break;
            case this.FMC_BtnOk:
               if(this.FBackFun != null)
               {
                  this.FBackFun(this.FCurIndex,this.FCostCount,this.FCuraddPro * this.FCostCount);
               }
               this.visible = false;
               break;
            case this.FMC_BtnCancel:
               this.visible = false;
         }
      }
      
      protected function OnTextInput(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         this.FCostCount = int(this.FTF_Num.text) > 0 ? int(this.FTF_Num.text) : 1;
         this.UpdateView();
      }
      
      protected function GetMaxValueByLevel() : uint
      {
         var _loc1_:TBins = null;
         var _loc2_:TFetters = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc5_ = this.FCurData.ConfigId;
         _loc1_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Fetters) as TBins;
         do
         {
            _loc2_ = _loc1_.GetDatebaseByIdentifier(_loc5_) as TFetters;
            if(_loc2_)
            {
               _loc4_ += _loc2_.ExpAll + 1 - _loc2_.NeedExp;
               _loc5_ += 1;
            }
         }
         while(_loc2_);
         if(this.FCurData.CurExpricence < this.FCurData.CurStartExpricence)
         {
            _loc5_ = 0;
         }
         else
         {
            _loc5_ = this.FCurData.CurExpricence - this.FCurData.CurStartExpricence;
         }
         return _loc4_ - _loc5_;
      }
      
      protected function UpdateView(param1:int = 0) : void
      {
         var _loc2_:uint = 0;
         if(param1 == 1)
         {
            _loc2_ = this.GetMaxValueByLevel();
            _loc2_ = Math.ceil(_loc2_ / this.FCuraddPro);
            this.FCostCount = this.count / this.FCurCostDian;
            if(_loc2_ < this.FCostCount)
            {
               this.FCostCount = _loc2_;
            }
            else
            {
               this.FCostCount = this.count / this.FCurCostDian;
            }
            if(this.FCostCount == 0)
            {
               this.FCostCount = 1;
            }
         }
         else if(this.FCostCount <= 0)
         {
            this.FCostCount = 1;
         }
         else if(this.FCostCount >= this.count / this.FCurCostDian)
         {
            this.FCostCount = this.count / this.FCurCostDian;
         }
         if(this.FCostCount >= 9999)
         {
            this.FCostCount = 9999;
         }
         this.FTF_Num.text = this.FCostCount.toString();
         this.FTF_Dec2.text = TUtilityString.Format(STRING_NINJARELATION.FORMAT_GetFriendValueNew,this.FCurCostDian * this.FCostCount,STRING_NINJARELATION.STRING_SOULS[this.FCurIndex - 1],this.FCuraddPro * this.FCostCount);
      }
      
      public function StartShow(param1:int, param2:Vector.<uint>, param3:TNinjaGroupBuff) : void
      {
         this.FCurIndex = param1;
         this.DateVec = param2;
         this.FCurData = param3;
         this.FCurCostDian = this.DateVec[(this.FCurIndex - 1) * 3 + 1];
         this.FCuraddPro = this.DateVec[(this.FCurIndex - 1) * 3 + 2];
         this.FTF_Dec1.text = TUtilityString.Format(STRING_NINJARELATION.FORMAT_GetFriendValueCa,this.FCurCostDian,STRING_NINJARELATION.STRING_SOULS[this.FCurIndex - 1],this.FCuraddPro);
         this.FCostCount = 1;
         switch(this.FCurIndex)
         {
            case CONST_NinjaRelationship.TYPE_GOLDCOIN:
               this.count = SLogicsCore.Character.CreditGold;
               break;
            case CONST_NinjaRelationship.TYPE_BLUESOUL:
               this.count = SLogicsCore.Character.HeroSoulBlueSoul;
               break;
            case CONST_NinjaRelationship.TYPE_PURPLESOUL:
               this.count = SLogicsCore.Character.HeroSoulPurpleSoul;
               break;
            case CONST_NinjaRelationship.TYPE_GOLDSOUL:
               this.count = SLogicsCore.Character.HeroSoulGoldSoul;
               break;
            case CONST_NinjaRelationship.TYPE_REDSOUL:
               this.count = SLogicsCore.Character.HeroSoulOrangeSoul;
         }
         this.UpdateView();
      }
      
      public function set BackFun(param1:Function) : void
      {
         this.FBackFun = param1;
      }
   }
}

