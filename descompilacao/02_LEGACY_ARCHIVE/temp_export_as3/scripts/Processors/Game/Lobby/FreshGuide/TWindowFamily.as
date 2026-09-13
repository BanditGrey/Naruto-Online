package Processors.Game.Lobby.FreshGuide
{
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Inventories.*;
   import Logics.Streamization.Inventories.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Windows.Information.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   
   public class TWindowFamily extends TProcessorLobbyWindow
   {
      
      protected var FRewardBox:MovieClip;
      
      protected var FRewardTip:MovieClip;
      
      protected var FBtn_Joins:Vector.<SimpleButton>;
      
      protected var FPromotWindow:TUIWindowConfirmation;
      
      protected var FSelectFamilyID:int;
      
      protected var FInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FFamilyId:uint;
      
      protected var FOnClickBtn:Function;
      
      protected var FOnHintMove:Function;
      
      protected var FOnHintOut:Function;
      
      public function TWindowFamily(param1:TUIComponent)
      {
         super(param1);
         this.FInventories = new TInventories();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FFamilyId = 0;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_FRESHGUIDE.RESOURCESID_FreshGuide_Family);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         var _loc3_:SimpleButton = null;
         var _loc4_:Vector.<uint> = null;
         var _loc5_:TConfigValue = null;
         _loc1_ = TUtilityReflection.CreateDisplayObjectInstance("Family") as MovieClip;
         this.addChild(_loc1_);
         this.FBtn_Joins = new Vector.<SimpleButton>();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc3_ = _loc1_["BTN_Join" + (_loc2_ + 1)];
            _loc3_.addEventListener(MouseEvent.CLICK,this.OnMouseClick);
            this.FBtn_Joins.push(_loc3_);
            _loc2_++;
         }
         this.FRewardBox = _loc1_.mc_rewordbox;
         this.FRewardTip = _loc1_.mc_rewordTip;
         this.FRewardBox.visible = false;
         this.FRewardTip.visible = false;
         this.FRewardBox.addEventListener(MouseEvent.MOUSE_MOVE,this.OnRewardMove);
         this.FRewardBox.addEventListener(MouseEvent.ROLL_OUT,this.OnRewardOut);
         this.FPromotWindow = new TUIWindowConfirmation(this.Parent);
         TUtilityUIWindow.SetupWindowConfirmation(this.FPromotWindow);
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.CHOOSE_FAMILY_AWARD) as TConfigValue;
         _loc4_ = Vector.<uint>([_loc5_.Value as uint]);
         this.FInventories.Clear();
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,_loc4_);
         if(this.FFamilyId != 0)
         {
            this.SetPunyFamily(this.FFamilyId);
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.x = (CONST_COMMON.STAGE_Width - this.width) / 2;
         this.y = (CONST_COMMON.STAGE_Height - this.height) / 2;
         this.FPromotWindow.x = (CONST_COMMON.STAGE_Width - this.FPromotWindow.WindowWidth) / 2;
         this.FPromotWindow.y = (CONST_COMMON.STAGE_Height - this.FPromotWindow.WindowHeight) / 2;
         super.ResourcesPerform_UILocations();
      }
      
      private function OnMouseClick(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SimpleButton = null;
         _loc3_ = param1.currentTarget as SimpleButton;
         _loc2_ = this.FBtn_Joins.indexOf(_loc3_);
         this.FSelectFamilyID = _loc2_ + 1;
         this.FPromotWindow.OnOK = this.PromotWindowOk;
         this.FPromotWindow.Text = TUtilityString.Format(STRING_COMMON.FormatString_FamilyPromotString,STRING_COMMON.FamilyNames[this.FSelectFamilyID]);
         this.FPromotWindow.visible = true;
      }
      
      protected function OnRewardMove(param1:MouseEvent) : void
      {
         if(this.FOnHintMove != null)
         {
            this.FOnHintMove(this,this.FInventories.GetInventoryByIndex(0));
         }
      }
      
      protected function OnRewardOut(param1:MouseEvent) : void
      {
         if(this.FOnHintOut != null)
         {
            this.FOnHintOut(this);
         }
      }
      
      protected function PromotWindowOk(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_FreshGuide_FamilyReq);
         _loc2_.Data.writeByte(this.FSelectFamilyID);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         visible = false;
         TutorialNextStep(1000);
         if(this.FOnClickBtn != null)
         {
            this.FOnClickBtn(this);
         }
      }
      
      public function set OnClickBtn(param1:Function) : void
      {
         this.FOnClickBtn = param1;
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         var _loc2_:TPacket = null;
         super.Visible = param1;
         if(param1)
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_FreshGuide_PunyFamilyReq);
            SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         }
      }
      
      public function set OnHintMove(param1:Function) : void
      {
         this.FOnHintMove = param1;
      }
      
      public function get OnHintMove() : Function
      {
         return this.FOnHintMove;
      }
      
      public function set OnHintOut(param1:Function) : void
      {
         this.FOnHintOut = param1;
      }
      
      public function get OnHintOut() : Function
      {
         return this.FOnHintOut;
      }
      
      public function UpdateFamily() : void
      {
         var _loc1_:String = null;
         _loc1_ = TUtilityString.Format(STRING_COMMON.FormatString_FamilyServerBackPromotString,STRING_COMMON.FamilyNames[this.FSelectFamilyID]);
         EffectGenerateText(_loc1_);
      }
      
      public function SetPunyFamily(param1:int) : void
      {
         this.FFamilyId = param1;
         if(this.FRewardBox != null)
         {
            if(param1 == 0)
            {
               this.FRewardBox.visible = false;
               this.FRewardTip.visible = false;
            }
            else
            {
               this.FRewardBox.visible = true;
               this.FRewardTip.visible = true;
               this.FRewardBox.x = 90 + 220 * (param1 - 1);
               this.FRewardBox.y = 400;
               this.FRewardTip.x = 180 + 220 * (param1 - 1);
               this.FRewardTip.y = 115;
            }
         }
      }
   }
}

