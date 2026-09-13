package Processors.Game.Lobby.Organization
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
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_ORGANIZATION;
   import Resources.Strings.STRING_ORGANIZATION;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowCallPet extends TProcessorLobbyWindow
   {
      
      public static const Three:int = 3;
      
      protected var FMC:Sprite;
      
      protected var FurGodIndex0:int = 1;
      
      protected var FAllGodIndex0:int = 1;
      
      protected var VecLists1:Vector.<TUISlot> = new Vector.<TUISlot>(Three);
      
      protected var FCallReward:Vector.<Object> = new Vector.<Object>();
      
      protected var FParticiPationReward:Vector.<Object> = new Vector.<Object>();
      
      protected var FOneRewardId:Vector.<uint> = new Vector.<uint>();
      
      protected var FOneRewardIdcount:Vector.<uint> = new Vector.<uint>();
      
      protected var FInventoriesOne:TInventories = new TInventories();
      
      protected var ScrText:TextField;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      
      protected var FSprite:Sprite = new Sprite();
      
      protected var FInitialized:Boolean;
      
      protected var CallCounGode:int;
      
      protected var FSureBtn:Function;
      
      public function TProcessorWindowCallPet(param1:TUIComponent)
      {
         super(param1);
      }
      
      public function BeginDraw() : void
      {
         this.FSprite.graphics.beginFill(0,0.3);
         this.FSprite.graphics.drawRect(0,0,FUICore.StageWidth,FUICore.StageHeight);
         this.FSprite.graphics.endFill();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_ORGANIZATION.RESOURCESID_Swf_OrganizationMain);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TConfigValue = null;
         var _loc2_:int = 0;
         var _loc3_:TUISlot = null;
         this.FMC = TUtilityReflection.CreateDisplayObjectInstance(CONST_ORGANIZATION.RESOURCE_ClassName_MC_OrgCallPet) as Sprite;
         addChild(this.FSprite);
         this.BeginDraw();
         this.FSprite.x = FUICore.StageWidth - this.FSprite.width >> 1;
         this.FSprite.y = FUICore.StageHeight - this.FSprite.height >> 1;
         this.FSprite.addChild(this.FMC);
         this.FMC.x = (this.FSprite.width - this.FMC.width) / 2;
         this.FMC.y = (this.FSprite.height - this.FMC.height) / 2;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.KillAnimalBossTimecall) as TConfigValue;
         this.FCallReward = _loc1_.Value as Vector.<Object>;
         _loc2_ = 0;
         while(_loc2_ < this.FCallReward.length)
         {
            this.FOneRewardId.push(this.FCallReward[_loc2_].code);
            this.FOneRewardIdcount.push(this.FCallReward[_loc2_].amount);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < Three)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC["mc_slot_" + _loc2_] as MovieClip;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.Tag = _loc2_;
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc3_.OnOverlay = this.UIComponentsHintOnOver;
            _loc3_.OnOut = this.UIComponentsHintOnOut;
            _loc3_.Init();
            this.VecLists1[_loc2_] = _loc3_;
            _loc2_++;
         }
         MovieClip(this.FMC["MC_right_btn0"]).addEventListener(MouseEvent.CLICK,this.PageClick);
         MovieClip(this.FMC["MC_left_btn0"]).addEventListener(MouseEvent.CLICK,this.PageClick);
         MovieClip(this.FMC["MC_Sure_Btn"]).addEventListener(MouseEvent.CLICK,this.PageClick);
         MovieClip(this.FMC["MC_Cance_Btn"]).addEventListener(MouseEvent.CLICK,this.PageClick);
         this.ScrText = this.FMC["TF_Prompt"];
         TGameUtil.setButtonMode(this.FMC["MC_Sure_Btn"],true);
         TGameUtil.setButtonMode(this.FMC["MC_Cance_Btn"],true);
         this.UnstreamizerInventoryReference();
         this.FOverlayerAppliance = new TOverlayerAppliance(FParent,CONST_MODULES.MODULE_Organization);
         this.FOverlayerAppliance.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
         this.Loadequip();
         this.FInitialized = true;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.KillAnimalBossTimeConsum) as TConfigValue;
         this.CallCounGode = _loc1_.Value as int;
         var _loc4_:Array = STRING_ORGANIZATION.FORMAT_Scr.split("&");
         this.ScrText.text = _loc4_[0] + this.CallCounGode + _loc4_[1];
         super.ResourcesPerform_UIDispatch();
      }
      
      public function PageClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC["MC_right_btn0"]:
               if(this.FurGodIndex0 < this.FAllGodIndex0)
               {
                  this.FurGodIndex0 += 1;
                  this.Loadequip();
               }
               break;
            case this.FMC["MC_left_btn0"]:
               if(this.FurGodIndex0 > 1)
               {
                  --this.FurGodIndex0;
                  this.Loadequip();
               }
               break;
            case this.FMC["MC_Sure_Btn"]:
               this.FSureBtn();
               this.CloseMe();
               break;
            case this.FMC["MC_Cance_Btn"]:
               this.CloseMe();
         }
      }
      
      protected function CloseMe() : void
      {
         this.visible = false;
      }
      
      public function set SureBtn(param1:Function) : void
      {
         this.FSureBtn = param1;
      }
      
      protected function setBtnState() : void
      {
         if(this.FAllGodIndex0 <= 1)
         {
            TGameUtil.setButtonMode(MovieClip(this.FMC["MC_left_btn0"]),false);
            TGameUtil.setButtonMode(MovieClip(this.FMC["MC_right_btn0"]),false);
            MovieClip(this.FMC["MC_left_btn0"]).visible = false;
            MovieClip(this.FMC["MC_right_btn0"]).visible = false;
         }
         else
         {
            TGameUtil.setButtonMode(MovieClip(this.FMC["MC_left_btn0"]),this.FurGodIndex0 == 1 ? false : true);
            TGameUtil.setButtonMode(MovieClip(this.FMC["MC_right_btn0"]),this.FurGodIndex0 >= this.FAllGodIndex0 ? false : true);
            if(this.FurGodIndex0 == 1)
            {
               MovieClip(this.FMC["MC_left_btn0"]).visible = false;
            }
            else
            {
               MovieClip(this.FMC["MC_left_btn0"]).visible = true;
            }
            if(this.FurGodIndex0 >= this.FAllGodIndex0)
            {
               MovieClip(this.FMC["MC_right_btn0"]).visible = false;
            }
            else
            {
               MovieClip(this.FMC["MC_right_btn0"]).visible = true;
            }
         }
      }
      
      protected function Loadequip() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:Number = Number(this.FInventoriesOne.Count);
         this.FAllGodIndex0 = Math.ceil(_loc2_ / Three);
         _loc1_ = 0;
         while(_loc1_ < Three)
         {
            _loc3_ = _loc1_ + (this.FurGodIndex0 - 1) * Three;
            if(_loc3_ > _loc2_ - 1)
            {
               this.VecLists1[_loc1_].Context = null;
            }
            else
            {
               this.VecLists1[_loc1_].Context = this.FInventoriesOne.GetInventoryByIndex(_loc3_);
            }
            _loc1_++;
         }
         this.setBtnState();
      }
      
      protected function UnstreamizerInventoryReference() : void
      {
         var _loc1_:int = 0;
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventoriesOne,this.FOneRewardId);
         _loc1_ = 0;
         while(_loc1_ < this.FInventoriesOne.Count)
         {
            this.FInventoriesOne.GetInventoryByIndex(_loc1_).Quantity = this.FOneRewardIdcount[_loc1_];
            _loc1_++;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Organization);
         }
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         _loc4_ = this.FOverlayerAppliance;
         if(_loc4_ != null)
         {
            _loc4_.Context = _loc3_;
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.Show();
         }
      }
      
      protected function UIComponentsHintOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         _loc4_ = this.FOverlayerAppliance;
         if(_loc4_ != null)
         {
            _loc4_.Hide();
         }
      }
      
      public function updateUI() : void
      {
         this.LogicsPerform();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(this.FInitialized && this.visible)
         {
            _loc1_ = 0;
            _loc1_ = 0;
            while(_loc1_ < Three)
            {
               if(_loc1_ + (this.FurGodIndex0 - 1) * Three <= this.FInventoriesOne.Count - 1)
               {
                  this.VecLists1[_loc1_].Update();
               }
               _loc1_++;
            }
         }
      }
   }
}

