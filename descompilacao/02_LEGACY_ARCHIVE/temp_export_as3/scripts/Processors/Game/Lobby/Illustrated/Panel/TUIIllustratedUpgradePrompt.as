package Processors.Game.Lobby.Illustrated.Panel
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArchiveCofig;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Illustrated.TIllustratedModel;
   import Resources.Constants.CONST_NETWORK;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TUIIllustratedUpgradePrompt extends TProcessorLobbyWindow
   {
      
      protected var FMC_Scene:MovieClip = null;
      
      protected var FType:int = 0;
      
      protected var FCallback:Function;
      
      protected var FCount:int;
      
      protected var FMaxCount:int = 10;
      
      public function TUIIllustratedUpgradePrompt(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(-(FUICore.StageWidth / 2),-(FUICore.StageHeight / 2),FUICore.StageWidth * 2,FUICore.StageHeight * 2);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_UpgradePrompt") as MovieClip;
         this.FMC_Scene.x = (FUICore.StageWidth - this.FMC_Scene.width) / 2;
         this.FMC_Scene.y = (FUICore.StageHeight - this.FMC_Scene.height) / 2;
         this.addChild(this.FMC_Scene);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_Scene.TF_Count.addEventListener(Event.CHANGE,this.OnCountChange);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Left,true);
         this.FMC_Scene.BTN_Left.addEventListener(MouseEvent.CLICK,this.OnLeftClick);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Right,true);
         this.FMC_Scene.BTN_Right.addEventListener(MouseEvent.CLICK,this.OnRightClick);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Max,true);
         this.FMC_Scene.BTN_Max.addEventListener(MouseEvent.CLICK,this.OnMaxClick);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Confirm,true);
         this.FMC_Scene.BTN_Confirm.addEventListener(MouseEvent.CLICK,this.OnConfirmClick);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Cancel,true);
         this.FMC_Scene.BTN_Cancel.addEventListener(MouseEvent.CLICK,this.OnCancelClick);
         super.ResourcesPerform_UILocations();
      }
      
      public function ShowPrompt(param1:int, param2:Function) : void
      {
         var _loc3_:TArchiveCofig = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         this.visible = true;
         this.FType = param1;
         this.FCallback = param2;
         if(this.FType == 1)
         {
            _loc3_ = TIllustratedModel.ArchiveCofig.GetDatebaseByIndex(0) as TArchiveCofig;
            this.FMaxCount = TIllustratedModel.FIllustrated.ChapterCount / _loc3_.Cost;
         }
         else
         {
            this.FMaxCount = 0;
            _loc4_ = 0;
            _loc5_ = TIllustratedModel.FIllustrated.GoldUpgradeCount + 1;
            _loc6_ = TIllustratedModel.ArchiveCofig.Count;
            _loc7_ = _loc5_;
            while(_loc7_ < _loc6_)
            {
               _loc3_ = TIllustratedModel.ArchiveCofig.GetDatebaseByIndex(_loc7_) as TArchiveCofig;
               _loc4_ += _loc3_.Cost;
               if(TIllustratedModel.FCharacter.CreditGold >= _loc4_)
               {
                  ++this.FMaxCount;
               }
               _loc7_++;
            }
         }
         this.Count = 1;
      }
      
      private function OnCountChange(param1:Event) : void
      {
         this.Count = this.FMC_Scene.TF_Count.text;
      }
      
      private function OnLeftClick(param1:MouseEvent) : void
      {
         --this.Count;
      }
      
      private function OnRightClick(param1:MouseEvent) : void
      {
         ++this.Count;
      }
      
      private function OnMaxClick(param1:MouseEvent) : void
      {
         this.Count = this.FMaxCount;
      }
      
      private function OnConfirmClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Illustrated_UpgradeReq);
         _loc2_.Data.writeUnsignedInt(this.FType);
         _loc2_.Data.writeUnsignedInt(this.FCount);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.visible = false;
      }
      
      private function OnCancelClick(param1:MouseEvent) : void
      {
         this.visible = false;
      }
      
      public function get Count() : int
      {
         return this.FCount;
      }
      
      public function set Count(param1:int) : void
      {
         var _loc2_:TArchiveCofig = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         this.FCount = Math.max(1,param1);
         this.FCount = Math.min(this.FMaxCount,this.FCount);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Left,this.FCount > 1);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Right,this.FCount < this.FMaxCount);
         this.FMC_Scene.TF_Count.text = this.FCount;
         if(this.FType == 1)
         {
            _loc2_ = TIllustratedModel.ArchiveCofig.GetDatebaseByIndex(0) as TArchiveCofig;
            this.FMC_Scene.TF_Desc.text = TUtilityString.Format(TIllustratedModel.SystemLanguage.GetDatebaseByIdentifier(70470013)["Desc"],_loc2_.Cost * this.FCount,_loc2_.GetExp * this.FCount);
         }
         else
         {
            _loc3_ = 0;
            _loc4_ = 0;
            _loc5_ = TIllustratedModel.FIllustrated.GoldUpgradeCount + 1;
            _loc6_ = _loc5_ + this.FCount;
            _loc7_ = _loc5_;
            while(_loc7_ < _loc6_)
            {
               _loc2_ = TIllustratedModel.ArchiveCofig.GetDatebaseByIndex(_loc7_) as TArchiveCofig;
               _loc3_ += _loc2_.Cost;
               _loc4_ += _loc2_.GetExp;
               _loc7_++;
            }
            this.FMC_Scene.TF_Desc.text = TUtilityString.Format(TIllustratedModel.SystemLanguage.GetDatebaseByIdentifier(70470012)["Desc"],_loc3_,_loc4_);
         }
      }
   }
}

