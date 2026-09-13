package Processors.Game.Lobby.Exercise.AccountSafe
{
   import Externals.SExternalCore;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
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
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorAccountSafe extends TProcessorLobbyWindows
   {
      
      public static const REWARD_ID:int = 60380112;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FTF_Input:TextField;
      
      protected var FTF_UserName:TextField;
      
      protected var FReward:Vector.<Object>;
      
      protected var FInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FOnOpenActivity:Function;
      
      public var OnLickProcessorAccountTransfer:Function;
      
      public function TProcessorAccountSafe(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(4060086274);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_AccountSafe") as MovieClip;
         addChild(this.FMC_Scene);
         this.FMC_Scene.x = (FUICore.StageWidth - this.FMC_Scene.width) / 2;
         this.FMC_Scene.y = (FUICore.StageHeight - this.FMC_Scene.height) / 2;
         this.FMC_Scene.BTN_Close.visible = false;
         this.FTF_Input = this.FMC_Scene["MC_PassWord"]["TF_PassWord"];
         this.FTF_Input.restrict = "a-zA-Z0-9";
         this.FTF_Input.maxChars = 22;
         this.FTF_UserName = this.FMC_Scene["TF_UserName"];
         this.FTF_UserName.restrict = "a-zA-Z0-9\\-@._";
         this.FTF_UserName.maxChars = 50;
         this.FShowItem = new TUIShowItem(this,6);
         this.FShowItem.Perform_UIDispatch(this.FMC_Scene["MC_ShowItems"]);
         this.FShowItem.OnOverlay = UIComponentsHintOnOver;
         this.FShowItem.OnOut = UIComponentsHintOnOut;
         SExternalCore.CallBackAccount = this.RegisterAccountCallBack;
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
         if(TUtilityString.Empty(SParametersNewCore.CollectPswd))
         {
            this.FTF_UserName.text = "";
            this.FTF_Input.text = "";
            this.FTF_UserName.mouseEnabled = true;
            this.FTF_Input.mouseEnabled = true;
         }
         else
         {
            this.FTF_UserName.text = SParametersNewCore.CollectEmail;
            this.FTF_Input.text = SParametersNewCore.CollectPswd;
            this.FTF_UserName.mouseEnabled = false;
            this.FTF_Input.mouseEnabled = false;
         }
      }
      
      protected function ProcessorEffectText(param1:String, param2:TEffectTextParameters = null, param3:TEffectCoordinateParameters = null, param4:uint = 5) : void
      {
         if(FOnEffectText != null)
         {
            FOnEffectText(this,param1,param2,param3,param4);
         }
      }
      
      protected function RegisterAccountCallBack(param1:Object) : void
      {
         if(param1 == 1001)
         {
            this.ProcessorEffectText("Provide your unique security account");
         }
         else if(param1 == 1002)
         {
            this.ProcessorEffectText("Please fill your security code");
         }
         else if(param1 == 1003)
         {
            this.ProcessorEffectText("Sorry, your serve still hasn\'t yet opened this function");
         }
         else if(param1 == 1000)
         {
            this.ProcessorEffectText("Sorry, this unique security has already existed, please provide  another name");
         }
         else if(param1 == 0)
         {
            this.CloseClick(null);
            SParametersNewCore.CollectEmail = this.FTF_UserName.text;
            SParametersNewCore.CollectPswd = this.FTF_Input.text;
            if(this.OnLickProcessorAccountTransfer != null)
            {
               this.OnLickProcessorAccountTransfer();
            }
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
         SExternalCore.CommitAccountSafe(this.FTF_Input.text,this.FTF_UserName.text);
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

