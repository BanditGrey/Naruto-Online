package Processors.Game.Lobby.OhtsutsukiKaguya.PanelMc
{
   import Components.ScrollBar.TScrollBar;
   import Components.Slots.TUISlot;
   import Components.Standard.TUITab;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TNightPowerConfig;
   import Logics.DatebaseVO.VO.TNightPowerPrivilege;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlow;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.OhtsutsukiKaguya.CellMc.TPSpriStripOne;
   import Processors.Game.Lobby.OhtsutsukiKaguya.CellMc.TPSpriStripTwo;
   import Processors.Game.Lobby.OhtsutsukiKaguya.Data.OhtsutsukiKaguyaData;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Rendering.Overlayers.OhtsutsukiKaguya.TOverOhtsutsukiKaguya;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_OhtsutsukiKaguya;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_OhtsutsukiKaguya;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorPanelTwo extends TProcessorLobbyWindow
   {
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var FMC_ROOT:MovieClip = null;
      
      protected var FBTN_Close:SimpleButton = null;
      
      protected var FTFtime_remaining:TextField = null;
      
      protected var FTFcur_level:TextField = null;
      
      protected var FTFget_exp:TextField = null;
      
      protected var FBTN_Confirm:SimpleButton = null;
      
      protected var FBTN_GetGift:MovieClip = null;
      
      protected var FMC_Tab01:MovieClip = null;
      
      protected var FMC_Tab02:MovieClip = null;
      
      protected var FScrollBar:TScrollBar = null;
      
      protected var Fmc_list:MovieClip = null;
      
      protected var FMC_Icon_text_0:TextField = null;
      
      protected var FMC_Icon_text_1:TextField = null;
      
      protected var FMC_Icon_Image_0:MovieClip = null;
      
      protected var FMC_Icon_Image_1:MovieClip = null;
      
      protected var FTF_EXP:TextField = null;
      
      protected var TempBins:TBins;
      
      protected var FOverOhtsutsukiKaguya:TOverOhtsutsukiKaguya;
      
      protected var FUITab:TUITab;
      
      protected var FMC_Slot:TUISlot;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSelectInventories:TInventories;
      
      protected var FTempSelectInventoriesId:Vector.<uint>;
      
      protected var EffectBaseGlow:TEffectBaseGlow = null;
      
      protected var FMC_Bar:MovieClip = null;
      
      protected var FIsExCute:Boolean;
      
      protected var FOverlayerEquipment:TOverlayerEquipment;
      
      protected var FOverlayerAccessory:TOverlayerAccessory;
      
      protected var FOverlayerTreasure:TOverlayerTreasure;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var FConfirmFun:Function = null;
      
      protected var FGetGiftFun:Function = null;
      
      protected var FJumpTerm:Function;
      
      protected var FLogicDate:OhtsutsukiKaguyaData = null;
      
      protected var FgetInitilization:Function;
      
      public function TProcessorPanelTwo(param1:TUIComponent)
      {
         super(param1);
         this.FOverOhtsutsukiKaguya = new TOverOhtsutsukiKaguya(param1.Parent);
         this.FOverOhtsutsukiKaguya.visible = false;
         this.FTempSelectInventoriesId = new Vector.<uint>();
         this.FSelectInventories = new TInventories();
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FOverlayerEquipment = new TOverlayerEquipment(this.Parent,CONST_MODULES.MODULE_Kaguya);
         this.FOverlayerEquipment.Visible = false;
         this.FOverlayerAccessory = new TOverlayerAccessory(this.Parent,CONST_MODULES.MODULE_Kaguya);
         this.FOverlayerAccessory.Visible = false;
         this.FOverlayerTreasure = new TOverlayerTreasure(this.Parent,CONST_MODULES.MODULE_Kaguya);
         this.FOverlayerTreasure.Visible = false;
         this.FOverlayerAppliance = new TOverlayerAppliance(this.Parent,CONST_MODULES.MODULE_Kaguya);
         this.FOverlayerAppliance.Visible = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_OhtsutsukiKaguya.This_Resource_Id);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC_ROOT = TUtilityReflection.CreateDisplayObjectInstance(CONST_OhtsutsukiKaguya.This_Panel_MC_PopupBox) as MovieClip;
         addChild(this.FMC_ROOT);
         this.FMC_ROOT.x = (FUICore.StageWidth - this.FMC_ROOT.width) / 2;
         this.FMC_ROOT.y = (FUICore.StageHeight - this.FMC_ROOT.height) / 2;
         this.FBTN_Close = this.FMC_ROOT["BTN_Close"];
         this.FTFtime_remaining = this.FMC_ROOT["time_remaining"];
         this.FTFcur_level = this.FMC_ROOT["cur_level"];
         this.FTFget_exp = this.FMC_ROOT["get_exp"];
         this.FBTN_Confirm = this.FMC_ROOT["Free_Trial_btn"];
         this.FBTN_GetGift = this.FMC_ROOT["BTN_GetGift"];
         this.FTF_EXP = this.FMC_ROOT["TF_EXP"];
         this.FMC_Bar = this.FMC_ROOT["MC_Bar"]["MC_Bar"];
         this.FMC_Tab01 = this.FMC_ROOT["tab_0"];
         this.FMC_Tab02 = this.FMC_ROOT["tab_1"];
         this.FMC_Icon_text_0 = this.FMC_ROOT["MC_Icon_0"]["TF_Dec"];
         this.FMC_Icon_text_1 = this.FMC_ROOT["MC_Icon_1"]["TF_Dec"];
         this.FMC_Icon_Image_0 = this.FMC_ROOT["MC_Icon_0"]["mc_icon"];
         this.FMC_Icon_Image_1 = this.FMC_ROOT["MC_Icon_1"]["mc_icon"];
         this.FUITab = new TUITab(this);
         this.FUITab.SetTabByIndex(this.FMC_Tab01,0);
         this.FUITab.SetTabByIndex(this.FMC_Tab02,1);
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.Fmc_list = this.FMC_ROOT["MC_List"];
         this.FMC_Slot = new TUISlot(this);
         this.FMC_Slot.Resource = this.FMC_ROOT["MC_Slot"];
         this.FMC_Slot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FMC_Slot.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FMC_Slot.OnOverlay = this.SlotsOnOver;
         this.FMC_Slot.OnOut = this.SlotsOnOut;
         this.FMC_Slot.Init();
         this.EffectBaseGlow = new TEffectBaseGlow();
         this.EffectBaseGlow.SetParameters(this.FBTN_GetGift,15911245,1);
         new Tools_Help(this,this.FMC_ROOT["BTN_Help"],CONST_SYSTEMLANGUAGE.HELPTIPS_Kaguya_help,FUICore);
         this.FScrollBar = new TScrollBar(this.Fmc_list,200,true,0,20,true);
         this.FScrollBar.Clear();
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverOhtsutsukiKaguya);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAccessory);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FLogicDate = SLogicsCore.KaguyaData;
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ClickHnadle);
         this.FBTN_Confirm.addEventListener(MouseEvent.CLICK,this.ClickHnadle);
         this.FBTN_GetGift.addEventListener(MouseEvent.CLICK,this.ClickHnadle);
         super.ResourcesPerform_UILocations();
      }
      
      protected function ClickHnadle(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FBTN_Close:
               Close();
               break;
            case this.FBTN_Confirm:
               if(this.FConfirmFun != null)
               {
                  this.FConfirmFun();
               }
               break;
            case this.FBTN_GetGift:
               if(this.FLogicDate.IsCanGetReward)
               {
                  return;
               }
               if(this.FGetGiftFun != null)
               {
                  this.FGetGiftFun();
               }
         }
      }
      
      override protected function ProcessorWindowClose() : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
         this.visible = false;
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(Boolean(this.FTFtime_remaining) && this.Visible)
         {
            this.FMC_Slot.Update();
            _loc1_ = SLogicsCore.KaguyaData.EndTime - STimingCore.GetServerTick();
            if(_loc1_ <= 0)
            {
               if(this.FgetInitilization != null && !this.FIsExCute)
               {
                  this.FgetInitilization();
                  this.FIsExCute = true;
               }
            }
            this.FTFtime_remaining.text = TGameUtil.fomatTime_Copy(_loc1_);
         }
         super.LogicsPerform();
      }
      
      public function set getInitilization(param1:Function) : void
      {
         this.FgetInitilization = param1;
      }
      
      public function OpenThisPanel() : void
      {
         this.UpdateView();
         this.TabOnSwitch(0);
         this.FUITab.TabIndex = 0;
         this.FIsExCute = false;
      }
      
      public function UpdateView() : void
      {
         this.FTFcur_level.text = String(this.FLogicDate.CurLevel);
         this.FTFget_exp.text = String(this.FLogicDate.CurLevelAllExp_);
         this.FMC_Bar.scaleX = Number(this.FLogicDate.CurExp / this.FLogicDate.CurNeedExp);
         this.FMC_Icon_text_0.text = TUtilityString.Format(STRING_OhtsutsukiKaguya.Middle_level,this.FLogicDate.CurLevel);
         this.FMC_Icon_Image_0.gotoAndStop(this.FLogicDate.CurLevel);
         if(this.FLogicDate.IsHighestLevel)
         {
            MovieClip(this.FMC_ROOT["MC_Icon_1"]).visible = false;
         }
         else
         {
            MovieClip(this.FMC_ROOT["MC_Icon_1"]).visible = true;
            this.FMC_Icon_text_1.text = TUtilityString.Format(STRING_OhtsutsukiKaguya.Middle_level,this.FLogicDate.NextLevel);
            this.FMC_Icon_Image_1.gotoAndStop(this.FLogicDate.NextLevel);
         }
         if(this.FLogicDate.IsCanGetReward)
         {
            TGameUtil.setButtonMode(this.FBTN_GetGift,false);
            this.EffectBaseGlow.Stop();
            this.EffectBaseGlow.visible = false;
         }
         else
         {
            TGameUtil.setButtonMode(this.FBTN_GetGift,true);
            this.EffectBaseGlow.Run();
            this.EffectBaseGlow.visible = true;
         }
         this.FTF_EXP.text = TUtilityString.Format(STRING_OhtsutsukiKaguya.Exp_Bar,this.FLogicDate.CurExp,this.FLogicDate.CurNeedExp);
         this.UpdateStuff();
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         if(_loc2_ == 0)
         {
            this.UpdateInterface01();
         }
         else
         {
            this.UpdateInterface02();
         }
      }
      
      public function UpdateStuff() : void
      {
         this.FTempSelectInventoriesId.length = 0;
         this.FSelectInventories.Clear();
         this.FTempSelectInventoriesId.push(this.FLogicDate.OneDAY);
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,this.FTempSelectInventoriesId);
         this.FMC_Slot.Context = this.FSelectInventories.GetInventoryByIndex(0);
      }
      
      protected function UpdateInterface02() : void
      {
         var _loc1_:int = 0;
         var _loc4_:TPSpriStripTwo = null;
         var _loc5_:TNightPowerConfig = null;
         this.FScrollBar.Clear();
         var _loc2_:TBins = SLogicsCore.KaguyaData.TNPowerConfig;
         var _loc3_:int = _loc2_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            if(_loc1_ < _loc3_ - 1)
            {
               _loc5_ = _loc2_.GetDatebaseByIndex(_loc1_) as TNightPowerConfig;
               _loc4_ = new TPSpriStripTwo();
               _loc4_.CurDate = _loc5_;
               this.FScrollBar.AddItem(_loc4_);
            }
            _loc1_++;
         }
         this.FScrollBar.ScrollToUp();
      }
      
      protected function UpdateInterface01() : void
      {
         this.FScrollBar.Clear();
         var _loc1_:int = 0;
         this.TempBins = SLogicsCore.KaguyaData.NPowerPrivilege;
         var _loc2_:int = this.TempBins.Count;
         var _loc3_:TPSpriStripOne = null;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc3_)
            {
               if(_loc3_.IsOver)
               {
                  break;
               }
            }
            _loc3_ = new TPSpriStripOne(_loc1_);
            _loc3_.SixOver = this.Over;
            _loc3_.SixClick = this.Click;
            _loc3_.SixOut = this.Out;
            _loc3_.SixMove = this.Move;
            _loc3_.UpdateFourData();
            this.FScrollBar.AddItem(_loc3_);
            _loc1_++;
         }
         this.FScrollBar.ScrollToUp();
      }
      
      public function UpdateImage() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TPSpriStripOne = null;
         _loc1_ = 0;
         while(_loc1_ < this.FScrollBar.Count)
         {
            _loc2_ = this.FScrollBar.Items[_loc1_] as TPSpriStripOne;
            if(_loc2_)
            {
               _loc2_.UpdateImage();
            }
            _loc1_++;
         }
         if(this.EffectBaseGlow.visible)
         {
            this.EffectBaseGlow.Run();
         }
      }
      
      protected function Over(param1:int, param2:Sprite) : void
      {
         var _loc3_:TNightPowerPrivilege = null;
         _loc3_ = SLogicsCore.KaguyaData.NPowerPrivilege.GetDatebaseByIndex(param1) as TNightPowerPrivilege;
         if(_loc3_.IsHold)
         {
            return;
         }
         if(!_loc3_.QuickLinks)
         {
            param2.buttonMode = false;
         }
         else
         {
            param2.buttonMode = true;
         }
         this.FOverOhtsutsukiKaguya.Context = _loc3_;
         this.FOverOhtsutsukiKaguya.Render(FUICore.MouseCoordinate);
         this.FOverOhtsutsukiKaguya.Show();
      }
      
      protected function Click(param1:int) : void
      {
         var _loc2_:TNightPowerPrivilege = null;
         _loc2_ = SLogicsCore.KaguyaData.NPowerPrivilege.GetDatebaseByIndex(param1) as TNightPowerPrivilege;
         if(_loc2_.QuickLinks)
         {
            this.FJumpTerm(_loc2_.QuickLinks);
         }
      }
      
      public function set JumpTerm(param1:Function) : void
      {
         this.FJumpTerm = param1;
      }
      
      protected function Out() : void
      {
         this.FOverOhtsutsukiKaguya.Hide();
      }
      
      protected function Move() : void
      {
         this.FOverOhtsutsukiKaguya.Render(FUICore.MouseCoordinate);
      }
      
      public function set ConfirmFun(param1:Function) : void
      {
         this.FConfirmFun = param1;
      }
      
      public function set GetGiftFun(param1:Function) : void
      {
         this.FGetGiftFun = param1;
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_Equipment:
               _loc4_ = this.FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc4_ = this.FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc4_ = this.FOverlayerAccessory;
               break;
            default:
               _loc4_ = this.FOverlayerAppliance;
         }
         if(_loc4_ != null)
         {
            _loc4_.Context = _loc3_;
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.Show();
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_Equipment:
               _loc4_ = this.FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc4_ = this.FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc4_ = this.FOverlayerAccessory;
               break;
            default:
               _loc4_ = this.FOverlayerAppliance;
         }
         if(_loc4_ != null)
         {
            _loc4_.Hide();
         }
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Kaguya);
         }
      }
   }
}

