package Processors.Game.Lobby.BindEmail
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityRegExpLibrary;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TErrorCode;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorBindEmail extends TProcessorLobbyWindows
   {
      
      public static const REWARD_ID:int = 60380110;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FTF_UserName:TextField;
      
      protected var FReward:Vector.<Object>;
      
      protected var FInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FOnOpenActivity:Function;
      
      public function TProcessorBindEmail(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(4060086273);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_Bangdingyouxiang") as MovieClip;
         addChild(this.FMC_Scene);
         this.FMC_Scene.x = (FUICore.StageWidth - this.FMC_Scene.width) / 2;
         this.FMC_Scene.y = (FUICore.StageHeight - this.FMC_Scene.height) / 2;
         this.FTF_UserName = this.FMC_Scene["TF_UserName"];
         this.FTF_UserName.restrict = "a-zA-Z0-9\\-@._";
         this.FTF_UserName.maxChars = 50;
         this.FShowItem = new TUIShowItem(this,6);
         this.FShowItem.Perform_UIDispatch(this.FMC_Scene["MC_ShowItems"]);
         this.FShowItem.OnOverlay = UIComponentsHintOnOver;
         this.FShowItem.OnOut = UIComponentsHintOnOut;
         super.ResourcesPerform_UIDispatch();
         this.UpdateUI();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FMC_Scene.BTN_Close.addEventListener(MouseEvent.CLICK,this.CloseClick);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Ok,true);
         this.FMC_Scene.BTN_Ok.addEventListener(MouseEvent.CLICK,this.ProcessorOnOkUp);
      }
      
      public function User_C2S_Mail_Req(param1:int = 0, param2:String = "") : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Mail_Req);
         _loc3_.Data.writeInt(param1);
         TUtilityString.FlushUTF(_loc3_.Data,param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Mail_Ret,this.PerformPacket_SC_Mail_Ret);
      }
      
      protected function PerformPacket_SC_Mail_Ret(param1:TPacket) : void
      {
         var _loc8_:TErrorCode = null;
         var _loc9_:String = null;
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ErrorCode,_loc3_) as TErrorCode;
            if(_loc8_ != null)
            {
               _loc9_ = _loc8_.Desc;
               if(EffectGenerateText != null)
               {
                  EffectGenerateText(_loc9_);
               }
            }
            return;
         }
         var _loc4_:int = _loc2_.readInt();
         var _loc5_:int = _loc2_.readInt();
         var _loc6_:String = _loc2_.readUTF();
         var _loc7_:Boolean = TUtilityString.Empty(_loc6_) && Boolean(_loc5_);
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_BindEmail,_loc7_);
         if(this.visible)
         {
            ProcessorClose();
         }
         if(this.FOnOpenActivity != null)
         {
            this.FOnOpenActivity();
         }
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:TConfigValue = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TInventory = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:Vector.<uint> = null;
         var _loc11_:Vector.<uint> = null;
         var _loc12_:TBins = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,REWARD_ID) as TConfigValue;
         _loc12_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         if(_loc1_)
         {
            this.FReward = _loc1_.Value as Vector.<Object>;
            _loc10_ = new Vector.<uint>();
            _loc11_ = new Vector.<uint>();
            this.FInventories = new TInventories();
            _loc4_ = int(this.FReward.length);
            _loc2_ = 0;
            while(_loc2_ < _loc4_)
            {
               _loc9_ = uint(this.FReward[_loc2_].type);
               _loc8_ = uint(this.FReward[_loc2_].code);
               _loc7_ = CONST_COMMON.GetItemIDByType(_loc9_,_loc8_,_loc12_);
               _loc10_.push(_loc7_);
               _loc11_.push(this.FReward[_loc2_].amount);
               _loc2_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,_loc10_);
            _loc2_ = 0;
            while(_loc2_ < _loc4_)
            {
               _loc6_ = this.FInventories.GetInventoryByIndex(_loc2_);
               _loc6_.Quantity = _loc11_[_loc2_];
               _loc2_++;
            }
            this.FShowItem.UpdateUI(this.FInventories);
         }
         this.UpdateText();
      }
      
      protected function UpdateText() : void
      {
         this.FMC_Scene.TF_UserName.text = "";
      }
      
      public function get OnOpenActivity() : Function
      {
         return this.FOnOpenActivity;
      }
      
      public function set OnOpenActivity(param1:Function) : void
      {
         this.FOnOpenActivity = param1;
      }
      
      public function CloseClick(param1:MouseEvent) : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      public function ProcessorOnOkUp(param1:MouseEvent) : void
      {
         var _loc2_:TErrorCode = null;
         var _loc3_:String = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!TUtilityRegExpLibrary.ValidateEmail(this.FTF_UserName.text))
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ErrorCode,1393) as TErrorCode;
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.Desc;
               if(EffectGenerateText != null)
               {
                  EffectGenerateText(_loc3_);
               }
            }
            return;
         }
         this.User_C2S_Mail_Req(1,this.FTF_UserName.text);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(FIsResourcesLoadCompleted && this.visible && this.FMC_Scene.visible)
         {
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
      }
   }
}

