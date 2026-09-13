package Processors.Game.Lobby.Exercise.AccountTransfer
{
   import Externals.SExternalCore;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Agent.SParametersCore;
   import Logics.Agent.SParametersNewCore;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_EFFECT;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorAccountTransfer extends TProcessorLobbyWindows
   {
      
      public static const CAPACITY_INVENTORIES:uint = CONST_COMMON.CAPACITY_INVENTORIES;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      public static const CAPACITY_ParallelOutputRows:uint = CONST_EFFECT.CAPACITY_ParallelOutputRows;
      
      public static const REWARD_ID:int = 60380008;
      
      public static const REWARD_ID_1:int = 60380107;
      
      public static const REWARD_ID_2:int = 60380108;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FTF_Input:TextField;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FShowItem_1:TUIShowItem;
      
      protected var FShowItem_2:TUIShowItem;
      
      protected var FTF_UserName:TextField;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FReward:Vector.<Object>;
      
      protected var FInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TProcessorAccountTransfer(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2550137128);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_AccountTransfer") as MovieClip;
         addChild(this.FMC_Scene);
         this.FMC_Scene.x = (FUICore.StageWidth - this.FMC_Scene.width) / 2;
         this.FMC_Scene.y = (FUICore.StageHeight - this.FMC_Scene.height) / 2;
         this.FBTN_Close = this.FMC_Scene.BTN_Close;
         this.FBTN_Close.visible = false;
         this.FTF_Input = this.FMC_Scene["MC_PassWord"]["TF_PassWord"];
         this.FTF_Input.restrict = "a-zA-Z0-9\\-";
         this.FTF_Input.maxChars = 22;
         this.FTF_Input.mouseEnabled = false;
         this.FTF_UserName = this.FMC_Scene["TF_UserName"];
         this.FTF_UserName.restrict = "a-zA-Z0-9\\-@._";
         this.FTF_UserName.maxChars = 50;
         this.FTF_UserName.mouseEnabled = false;
         this.FShowItem = new TUIShowItem(this,8);
         this.FShowItem.OnOverlay = UIComponentsHintOnOver;
         this.FShowItem.OnOut = UIComponentsHintOnOut;
         this.FShowItem_1 = new TUIShowItem(this,2);
         this.FShowItem_1.Perform_UIDispatch(this.FMC_Scene["MC_ShowItems_1"]);
         this.FShowItem_1.OnOverlay = UIComponentsHintOnOver;
         this.FShowItem_1.OnOut = UIComponentsHintOnOut;
         this.FShowItem_2 = new TUIShowItem(this,2);
         this.FShowItem_2.Perform_UIDispatch(this.FMC_Scene["MC_ShowItems_2"]);
         this.FShowItem_2.OnOverlay = UIComponentsHintOnOver;
         this.FShowItem_2.OnOut = UIComponentsHintOnOut;
         FOverlayerEquipment = new TOverlayerEquipment(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerEquipment.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerAppliance.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerAccessory.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         super.ResourcesPerform_UIDispatch();
         this.UpdateUI();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.CloseClick);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Ok,true);
         this.FMC_Scene.BTN_Ok.addEventListener(MouseEvent.CLICK,this.ProcessorOnOkUp);
         this.FTF_Input.addEventListener(Event.CHANGE,this.OnTextInput,false,0,true);
         this.FTF_UserName.addEventListener(Event.CHANGE,this.OnTextInput,false,0,true);
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:TConfigValue = null;
         var _loc2_:TConfigValue = null;
         var _loc3_:TConfigValue = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:Vector.<uint> = null;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:TBins = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,REWARD_ID) as TConfigValue;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,REWARD_ID_1) as TConfigValue;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,REWARD_ID_2) as TConfigValue;
         _loc14_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         if(_loc2_)
         {
            this.FReward = _loc2_.Value as Vector.<Object>;
            _loc12_ = new Vector.<uint>();
            _loc13_ = new Vector.<uint>();
            this.FInventories = new TInventories();
            _loc6_ = 2;
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc11_ = uint(this.FReward[_loc4_].type);
               _loc10_ = uint(this.FReward[_loc4_].code);
               _loc9_ = CONST_COMMON.GetItemIDByType(_loc11_,_loc10_,_loc14_);
               _loc12_.push(_loc9_);
               _loc13_.push(this.FReward[_loc4_].amount);
               _loc4_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,_loc12_);
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc8_ = this.FInventories.GetInventoryByIndex(_loc4_);
               _loc8_.Quantity = _loc13_[_loc4_];
               _loc4_++;
            }
            this.FShowItem_1.UpdateUI(this.FInventories);
         }
         if(_loc1_)
         {
            this.FReward = _loc1_.Value as Vector.<Object>;
            _loc12_ = new Vector.<uint>();
            _loc13_ = new Vector.<uint>();
            this.FInventories = new TInventories();
            _loc6_ = int(this.FReward.length);
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc11_ = uint(this.FReward[_loc4_].type);
               _loc10_ = uint(this.FReward[_loc4_].code);
               _loc9_ = CONST_COMMON.GetItemIDByType(_loc11_,_loc10_,_loc14_);
               _loc12_.push(_loc9_);
               _loc13_.push(this.FReward[_loc4_].amount);
               _loc4_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,_loc12_);
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc8_ = this.FInventories.GetInventoryByIndex(_loc4_);
               _loc8_.Quantity = _loc13_[_loc4_];
               _loc4_++;
            }
         }
         if(_loc3_)
         {
            this.FReward = _loc3_.Value as Vector.<Object>;
            _loc12_ = new Vector.<uint>();
            _loc13_ = new Vector.<uint>();
            this.FInventories = new TInventories();
            _loc6_ = 2;
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc11_ = uint(this.FReward[_loc4_].type);
               _loc10_ = uint(this.FReward[_loc4_].code);
               _loc9_ = CONST_COMMON.GetItemIDByType(_loc11_,_loc10_,_loc14_);
               _loc12_.push(_loc9_);
               _loc13_.push(this.FReward[_loc4_].amount);
               _loc4_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,_loc12_);
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc8_ = this.FInventories.GetInventoryByIndex(_loc4_);
               _loc8_.Quantity = _loc13_[_loc4_];
               _loc4_++;
            }
            this.FShowItem_2.UpdateUI(this.FInventories);
         }
         this.UpdateText();
      }
      
      protected function UpdateText() : void
      {
         this.FMC_Scene.TF_UserName.text = "";
         if(!SParametersNewCore.CollectPswd || SParametersNewCore.CollectPswd == "")
         {
            this.FTF_Input.text = "";
            this.FTF_UserName.text = "";
         }
         else
         {
            this.FTF_UserName.text = SParametersNewCore.CollectEmail;
            this.FTF_Input.text = SParametersNewCore.CollectPswd;
         }
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
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         SExternalCore.AccountTransfer(this.FTF_Input.text,this.FTF_UserName.text);
         SExternalCore.VkCallJs(20150429);
         this.ProcessorEffectText("");
      }
      
      public function RegisterSuccessCallBack(param1:Object = null) : void
      {
         var _loc2_:String = null;
         if(param1)
         {
            if(param1 == 0)
            {
               this.ProcessorEffectText("register failed");
               this.UpdateText();
            }
            else
            {
               this.ProcessorEffectText("register successed");
               SExternalCore.VkCallJs(20150430);
               _loc2_ = "http://www.plaync100.us";
               SExternalCore.NavigateToUrl(_loc2_);
               SParametersCore.PassWord1377 = this.FTF_Input.text;
               SParametersCore.PassWord = this.FTF_Input.text;
               SParametersCore.Email = this.FTF_UserName.text;
               this.UpdateText();
            }
         }
      }
      
      protected function OnTextInput(param1:Event) : void
      {
      }
      
      protected function ProcessorEffectText(param1:String, param2:TEffectTextParameters = null, param3:TEffectCoordinateParameters = null, param4:uint = 5) : void
      {
         if(FOnEffectText != null)
         {
            FOnEffectText(this,param1,param2,param3,param4);
         }
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
            if(this.FShowItem_1)
            {
               this.FShowItem_1.LogicsPerform();
            }
            if(this.FShowItem_2)
            {
               this.FShowItem_2.LogicsPerform();
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

