package Processors.Game.Lobby.RebirthRealm
{
   import Components.Slots.TUISlot;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowSixRebirthPanel extends TProcessorLobbyWindow
   {
      
      protected static const BASEATTRIBUTENAMES:Vector.<uint> = CONST_COMMON.BASEATTRIBUTENAMES;
      
      protected static const STRINGS_BASEATTRIBUTENAMES:Vector.<String> = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES;
      
      protected var FRootPanel:MovieClip;
      
      protected var FUISlot:TUISlot;
      
      protected var FMC_BreakThrough:MovieClip = null;
      
      protected var FTF_NeedOrAll:TextField = null;
      
      protected var FUIComponentsHintOnOver:Function = null;
      
      protected var FUIComponentsHintOnOut:Function = null;
      
      protected var FUpgradeBtn:Function = null;
      
      protected var FRebirthRealmBaseData:TRebirthRealmBaseData = null;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSelectInventories:TInventories;
      
      protected var FTempSelectInventoriesId:Vector.<uint>;
      
      public function TProcessorWindowSixRebirthPanel(param1:TUIComponent, param2:TRebirthRealmBaseData)
      {
         super(param1);
         this.FRebirthRealmBaseData = param2;
         this.FTempSelectInventoriesId = new Vector.<uint>();
         this.FSelectInventories = new TInventories();
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      public function SetThisPanel(param1:MovieClip) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.FRootPanel = param1;
         this.FUISlot = new TUISlot(FParent);
         this.FUISlot.Resource = this.FRootPanel["MC_Slot"];
         this.FUISlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FUISlot.Tag = 0;
         this.FUISlot.OnQuerySequenceContext = this.SequenceContextF;
         this.FUISlot.OnOverlay = this.UIComponentsHintOnOverF;
         this.FUISlot.OnOut = this.UIComponentsHintOnOutF;
         this.FUISlot.Init();
         this.ShowStuff();
         this.FMC_BreakThrough = this.FRootPanel["MC_BreakThrough"];
         TGameUtil.setButtonMode(this.FMC_BreakThrough,true);
         this.FMC_BreakThrough.addEventListener(MouseEvent.CLICK,this.UpgradeBtnClick);
         this.FUISlot.Context = this.FSelectInventories.GetInventoryByIndex(0);
         this.FTF_NeedOrAll = this.FRootPanel["TF_NeedOrAll"];
         var _loc2_:Array = null;
         _loc2_ = this.FRebirthRealmBaseData.SixSamsaraAttributeDescribe;
         if(_loc2_ == null)
         {
            throw new Error("配置错误！");
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = BASEATTRIBUTENAMES.indexOf(_loc2_[_loc3_][0]);
            TextField(this.FRootPanel["TF_Property_Describe_0" + _loc3_]).text = STRINGS_BASEATTRIBUTENAMES[_loc4_];
            TextField(this.FRootPanel["TF_Property_Describe_1" + _loc3_]).text = STRINGS_BASEATTRIBUTENAMES[_loc4_];
            _loc3_++;
         }
         new Tools_Help(FParent,this.FRootPanel["BTN_Help"],CONST_SYSTEMLANGUAGE.HELPTIPS_RebirthSix_help,FUICore);
      }
      
      public function UpdatePerform() : void
      {
         this.FUISlot.Update();
      }
      
      public function UpdateManual() : void
      {
         var _loc1_:int = 0;
         TextField(this.FRootPanel["TF_What_what_star"]).text = this.FRebirthRealmBaseData.SixSamsaraName;
         _loc1_ = 0;
         while(_loc1_ < this.FRebirthRealmBaseData.SixSamsaraLevel)
         {
            MovieClip(this.FRootPanel["mc_star_" + _loc1_]).visible = true;
            _loc1_++;
         }
         _loc1_ = this.FRebirthRealmBaseData.SixSamsaraLevel;
         while(_loc1_ < 10)
         {
            MovieClip(this.FRootPanel["mc_star_" + _loc1_]).visible = false;
            _loc1_++;
         }
         this.FRebirthRealmBaseData.SixSamsaraStuffId = this.FRebirthRealmBaseData.SixSamsaraId < 10000701 ? 14107082 : 14111299;
         this.ValuationOperation();
         if(this.GetFalseOrFalse())
         {
            this.FTF_NeedOrAll.textColor = 65280;
         }
         else
         {
            this.FTF_NeedOrAll.textColor = 16711680;
         }
         this.ShowStuff();
         this.FTF_NeedOrAll.text = SLogicsCore.Character.Appliances.GetAllCountByTempletID(this.FRebirthRealmBaseData.SixSamsaraStuffId) + "/" + this.FRebirthRealmBaseData.SixSamsaraStuffNum;
         this.FUISlot.Context = this.FSelectInventories.GetInventoryByIndex(0);
      }
      
      public function ValuationOperation() : void
      {
         var _loc1_:int = 0;
         if(this.FRebirthRealmBaseData.SixSamsaraAttribute.length)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FRebirthRealmBaseData.SixSamsaraAttribute.length)
            {
               TextField(this.FRootPanel["TF_Attr0" + _loc1_]).text = String(this.FRebirthRealmBaseData.SixSamsaraAttribute[_loc1_][1]);
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < this.FRebirthRealmBaseData.SixSamsaraAttributeDescribe.length)
            {
               TextField(this.FRootPanel["TF_Attr0" + _loc1_]).text = "0";
               _loc1_++;
            }
         }
         if(this.FRebirthRealmBaseData.SixSamsaraNextAttribute.length)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FRebirthRealmBaseData.SixSamsaraNextAttribute.length)
            {
               TextField(this.FRootPanel["TF_Attr1" + _loc1_]).text = String(this.FRebirthRealmBaseData.SixSamsaraNextAttribute[_loc1_][1]);
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < this.FRebirthRealmBaseData.SixSamsaraAttributeDescribe.length)
            {
               TextField(this.FRootPanel["TF_Attr1" + _loc1_]).text = "0";
               _loc1_++;
            }
         }
      }
      
      public function UpgradeBtnClick(param1:MouseEvent) : void
      {
         if(this.FUpgradeBtn != null)
         {
            this.FUpgradeBtn();
         }
      }
      
      public function set UpgradeBtn(param1:Function) : void
      {
         this.FUpgradeBtn = param1;
      }
      
      public function set UIComponentsHintOnOver(param1:Function) : void
      {
         this.FUIComponentsHintOnOver = param1;
      }
      
      public function set UIComponentsHintOnOut(param1:Function) : void
      {
         this.FUIComponentsHintOnOut = param1;
      }
      
      protected function UIComponentsHintOnOverF(param1:Object, param2:Object) : void
      {
         if(this.FUIComponentsHintOnOver != null)
         {
            this.FUIComponentsHintOnOver(param1,param2);
         }
      }
      
      protected function UIComponentsHintOnOutF(param1:Object, param2:Object) : void
      {
         if(this.FUIComponentsHintOnOut != null)
         {
            this.FUIComponentsHintOnOut(param1,param2);
         }
      }
      
      protected function SequenceContextF(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = SResourcesCore.TexturesInventory;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_RebirthRealm);
         }
      }
      
      protected function QuerySubscriptF(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      protected function ShowStuff() : void
      {
         this.FTempSelectInventoriesId.length = 0;
         this.FSelectInventories.Clear();
         this.FTempSelectInventoriesId.push(this.FRebirthRealmBaseData.SixSamsaraStuffId);
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,this.FTempSelectInventoriesId);
      }
      
      protected function GetFalseOrFalse() : Boolean
      {
         return SLogicsCore.Character.Appliances.GetAllCountByTempletID(this.FRebirthRealmBaseData.SixSamsaraStuffId) >= this.FRebirthRealmBaseData.SixSamsaraStuffNum;
      }
      
      public function SlotReset() : void
      {
         if(this.FUISlot)
         {
            this.FUISlot.Context = null;
         }
      }
   }
}

