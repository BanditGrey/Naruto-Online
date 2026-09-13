package Processors.Game.Lobby.Wing
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TWingAdvanced;
   import Logics.DatebaseVO.VO.TWingUpgrade;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Wing.TWing;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.MainScene.Role.TUIRole;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MainScene;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TITLE;
   import Resources.Strings.STRING_WING;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import ghostcat.util.data.Json;
   
   public class TUIWingTransform extends TUIBaseWindow
   {
      
      public static const TAB_COUNT:uint = 11;
      
      public static const TAB_COUNT_1:uint = 2;
      
      public static const SHOW_ITEM_COUNT:uint = 3;
      
      public static const TAB_BASE_WING:int = 0;
      
      public static const TAB_SPECIAL_WING:int = 1;
      
      public static const TAB_STAND_BY:int = 0;
      
      public static const TAB_FLY:int = 1;
      
      protected var FWing:TWing;
      
      protected var FUITab:TUITab;
      
      protected var FUITab1:TUITab;
      
      protected var FUITab2:TUITab;
      
      protected var FTF_Time:TextField;
      
      protected var FTF_Count:TextField;
      
      protected var FUIPage:TUIPage;
      
      protected var FPageIndex:int;
      
      protected var FWingIndex:int;
      
      protected var FChangeTabIndex1:int;
      
      protected var FChangeTabIndex2:int;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FMC_Role:MovieClip;
      
      protected var FCurWing:TWingAdvanced;
      
      protected var FWingBitmap:Bitmap;
      
      protected var FRoleBitmap:Bitmap;
      
      protected var FRole:TUIRole;
      
      public function TUIWingTransform(param1:TUIComponent)
      {
         super(param1);
         this.FWing = SLogicsCore.Character.Wing;
         this.FUITab = new TUITab(this);
         this.FUITab1 = new TUITab(this);
         this.FUITab2 = new TUITab(this);
         this.FRole = new TUIRole(this);
         this.FUIPage = new TUIPage(this);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         this.FTF_Time = FMC_Scene["TF_Time"];
         this.FTF_Count = FMC_Scene["MC_Info"]["TF_Count"];
         this.FMC_Role = FMC_Scene["MC_Role"];
         this.FMC_Role.addChild(this.FRole);
         this.FMC_Role.mouseEnabled = false;
         this.FMC_Role.mouseChildren = false;
         _loc2_ = 0;
         while(_loc2_ < TAB_COUNT)
         {
            this.FUITab.SetTabByIndex(FMC_Scene["MC_Tab" + _loc2_],_loc2_);
            _loc2_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         _loc2_ = 0;
         while(_loc2_ < TAB_COUNT_1)
         {
            this.FUITab1.SetTabByIndex(FMC_Scene["BTN_Tab" + _loc2_],_loc2_);
            _loc2_++;
         }
         this.FUITab1.OnSwitch = this.TabOnSwitch1;
         this.FUITab1.Init();
         _loc2_ = 0;
         while(_loc2_ < TAB_COUNT_1)
         {
            this.FUITab2.SetTabByIndex(FMC_Scene["BTN_Status" + _loc2_],_loc2_);
            _loc2_++;
         }
         this.FUITab2.OnSwitch = this.TabOnSwitch2;
         this.FUITab2.Init();
         this.FUIPage.LabelPage = FMC_Scene["MC_Page"]["TF_Page"];
         this.FUIPage.ButtonNext.Substrate = FMC_Scene["MC_Page"]["MC_PageRight"];
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene["MC_Page"]["MC_PageLeft"];
         this.FUIPage.OnChangePage = this.ProcessorOnChangePage;
         this.FUIPage.PageSize = TAB_COUNT;
         this.FUIPage.Init();
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_Info);
         this.FShowItem.OnOverlay = this.ProcessorOnItemOver;
         this.FShowItem.OnOut = this.ProcessorOnItemOut;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Transform,true);
         FMC_Scene.BTN_Transform.addEventListener(MouseEvent.CLICK,this.ProcessorOnTransformUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Activate,true);
         FMC_Scene.BTN_Activate.addEventListener(MouseEvent.CLICK,this.ProcessorOnTransformUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Hide,true);
         FMC_Scene.BTN_Hide.addEventListener(MouseEvent.CLICK,this.ProcessorOnHideUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Show,true);
         FMC_Scene.BTN_Show.addEventListener(MouseEvent.CLICK,this.ProcessorOnHideUp);
      }
      
      protected function UpdateTab() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:Vector.<TWingAdvanced> = null;
         var _loc5_:TWingAdvanced = null;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc10_:TWingUpgrade = null;
         var _loc11_:int = 0;
         var _loc12_:uint = 0;
         _loc4_ = this.FChangeTabIndex1 == TAB_BASE_WING ? this.FWing.BaseWings : this.FWing.SpeicalWings;
         this.FUIPage.TotalQuantity = _loc4_.length;
         this.FUIPage.Update();
         if(this.FChangeTabIndex1 == TAB_BASE_WING)
         {
            FMC_Scene.BTN_Tab0.MC_Select.visible = true;
            FMC_Scene.BTN_Tab1.MC_Select.visible = false;
         }
         else
         {
            FMC_Scene.BTN_Tab0.MC_Select.visible = false;
            FMC_Scene.BTN_Tab1.MC_Select.visible = true;
         }
         if(this.FChangeTabIndex2 == TAB_STAND_BY)
         {
            FMC_Scene.BTN_Status0.MC_Select.visible = true;
            FMC_Scene.BTN_Status1.MC_Select.visible = false;
         }
         else
         {
            FMC_Scene.BTN_Status0.MC_Select.visible = false;
            FMC_Scene.BTN_Status1.MC_Select.visible = true;
         }
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            _loc3_ = FMC_Scene["MC_Tab" + _loc1_];
            _loc2_ = _loc1_ + this.FPageIndex * TAB_COUNT;
            if(_loc2_ < _loc4_.length)
            {
               _loc3_.visible = true;
               _loc5_ = _loc4_[_loc2_] as TWingAdvanced;
               _loc3_.MC_Got.visible = this.FWing.TransformID == _loc5_.Identifier ? true : false;
               _loc3_.TF_Name.text = _loc5_.name;
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
         this.FCurWing = _loc4_[this.FWingIndex] as TWingAdvanced;
         if(this.FCurWing.illusionType == 1)
         {
            FMC_Scene.MC_Info.visible = false;
            FMC_Scene.MC_Base.visible = true;
            FMC_Scene.MC_Base.TF_Name.text = this.FCurWing.name;
            FMC_Scene.MC_Base.TF_Desc.text = this.FCurWing.description;
         }
         else
         {
            FMC_Scene.MC_Info.visible = true;
            FMC_Scene.MC_Base.visible = false;
            FMC_Scene.MC_Info.TF_Name.text = this.FCurWing.name;
            FMC_Scene.MC_Info.TF_Desc.text = this.FCurWing.description;
            _loc6_ = Json.decode(this.FCurWing.additionClient);
            if(_loc6_[0].length > 0)
            {
               _loc8_ = "";
               _loc1_ = 0;
               while(_loc1_ < _loc6_.length)
               {
                  _loc7_ = new ConsumeFrameCopy(_loc6_[_loc1_][0]).DescribeString;
                  _loc2_ = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc6_[_loc1_][1]);
                  if(_loc6_[_loc1_][2] < 1)
                  {
                     _loc9_ = _loc6_[_loc1_][2] * 100;
                     _loc8_ += TUtilityString.Format(_loc7_,STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc2_],_loc9_) + "\n";
                  }
                  else
                  {
                     _loc8_ += TUtilityString.Format(_loc7_,STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc2_],_loc6_[_loc1_][2]) + "\n";
                  }
                  _loc1_++;
               }
            }
            else
            {
               _loc8_ = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_018).DescribeString;
            }
            FMC_Scene.MC_Info.TF_Buff.text = _loc8_;
         }
         if(this.FWing.WingID >= this.FCurWing.needStage && SLogicsCore.Character.VipLevel >= this.FCurWing.vipLimit)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Transform,this.FCurWing.Identifier != this.FWing.TransformID);
            if(this.FCurWing.activatetime > this.FWing.GetWingTransformCountByID(this.FCurWing.Identifier))
            {
               TGameUtil.setButtonMode(FMC_Scene.BTN_Activate,true);
            }
            else
            {
               TGameUtil.setButtonMode(FMC_Scene.BTN_Activate,false);
            }
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Transform,false);
            TGameUtil.setButtonMode(FMC_Scene.BTN_Activate,false);
         }
         this.FTF_Count.text = this.FWing.GetWingTransformCountByID(this.FCurWing.Identifier).toString();
         TextField(FMC_Scene.TF_WingLevel).textColor = this.FWing.WingID >= this.FCurWing.needStage ? uint(4285071106) : uint(4294836224);
         TextField(FMC_Scene.TF_VipLevel).textColor = SLogicsCore.Character.VipLevel >= this.FCurWing.vipLimit ? uint(4285071106) : uint(4294836224);
         if(this.FCurWing.vipLimit == 0)
         {
            FMC_Scene.TF_VipLevel.text = "";
         }
         else
         {
            FMC_Scene.TF_VipLevel.text = TUtilityString.Format(new ConsumeFrameCopy(STRING_WING.WINGS_STRING_029).DescribeString,this.FCurWing.vipLimit);
         }
         _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_WingUpgrade,this.FCurWing.needStage) as TWingUpgrade;
         if(_loc10_)
         {
            FMC_Scene.TF_WingLevel.text = _loc10_.name;
         }
         else
         {
            FMC_Scene.TF_WingLevel.text = "";
         }
         if(this.FCurWing.ExpendItems)
         {
            _loc12_ = this.FCurWing.ExpendItems.GetInventoryByIndex(0).IDTemplate;
            this.FShowItem.QuantityStr = this.GetItemCountByID(_loc12_).toString();
            this.FShowItem.UpdateUI(this.FCurWing.ExpendItems);
         }
         else
         {
            this.FShowItem.UpdateUI(null);
         }
         if(this.FWing.TransformID != this.FCurWing.Identifier)
         {
            FMC_Scene.BTN_Show.visible = false;
            FMC_Scene.BTN_Hide.visible = false;
         }
         else if(this.FWing.HideWing == 2)
         {
            FMC_Scene.BTN_Show.visible = false;
            FMC_Scene.BTN_Hide.visible = true;
         }
         else
         {
            FMC_Scene.BTN_Show.visible = true;
            FMC_Scene.BTN_Hide.visible = false;
         }
      }
      
      protected function UpdateWingEffect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = this.FChangeTabIndex2 == TAB_STAND_BY ? int(CONST_MainScene.INDEX_IDLE) : int(CONST_MainScene.INDEX_FLY);
         this.FRole.ChangeTextureID(SLogicsCore.Character.MainHero.ModelID);
         this.FRole.TransformID = this.FCurWing.Identifier;
         this.FRole.HideWing = 2;
         this.FRole.ChangeDirection(CONST_MainScene.DIRECTION_RIGHT);
         this.FRole.ChangeRoleState(_loc1_);
         this.FRole.MapX = SLogicsCore.ScreenMapX;
         this.FRole.Update();
      }
      
      protected function GetItemCountByID(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TInventories = null;
         var _loc5_:TInventory = null;
         var _loc6_:uint = 0;
         _loc4_ = SLogicsCore.Character.Appliances;
         _loc3_ = uint(_loc4_.Count);
         _loc6_ = 0;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = _loc4_.GetInventoryByIndex(_loc2_);
            if(_loc5_.IDTemplate == param1)
            {
               _loc6_ += _loc5_.Quantity;
            }
            _loc2_++;
         }
         return _loc6_;
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FWingIndex = this.FPageIndex * TAB_COUNT + (param1 as int);
         this.UpdateTab();
      }
      
      protected function TabOnSwitch1(param1:Object) : void
      {
         this.FChangeTabIndex1 = param1 as int;
         this.FUIPage.Reset();
         this.FPageIndex = 0;
         this.FWingIndex = 0;
         this.FUITab.Reset();
         this.UpdateTab();
      }
      
      protected function TabOnSwitch2(param1:Object) : void
      {
         this.FChangeTabIndex2 = param1 as int;
         this.UpdateTab();
      }
      
      protected function ProcessorOnItemOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(param1,param2);
         }
      }
      
      protected function ProcessorOnItemOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(param1,param2);
         }
      }
      
      protected function ProcessorOnTransformUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TInventory = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null && Boolean(this.FCurWing))
         {
            if(param1.currentTarget == FMC_Scene.BTN_Activate)
            {
               _loc4_ = 0;
               if(this.FWing.GetWingTransformTimeByID(this.FCurWing.Identifier) < STimingCore.GetServerTick() && Boolean(this.FCurWing.ExpendItems))
               {
                  _loc2_ = 0;
                  while(_loc2_ < this.FCurWing.ExpendItems.Count)
                  {
                     _loc6_ = this.FCurWing.ExpendItems.GetInventoryByIndex(0);
                     _loc5_ = int(this.GetItemCountByID(_loc6_.IDTemplate));
                     if(_loc5_ < _loc6_.Quantity)
                     {
                        _loc4_ += (_loc6_.Quantity - _loc5_) * _loc6_.MaxPrice;
                     }
                     _loc2_++;
                  }
               }
               if(_loc4_ > 0)
               {
                  _loc3_ = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_020).DescribeString;
                  _loc3_ = TUtilityString.Format(_loc3_,_loc4_);
                  FOnBuyBox(TProcessorWing.TRANSFORM_WING,_loc4_,this.FCurWing.Identifier,0,_loc3_,0,0,1);
               }
               else
               {
                  _loc3_ = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_024).DescribeString;
                  FOnBuyBox(TProcessorWing.TRANSFORM_WING,0,this.FCurWing.Identifier,0,_loc3_,0,0,1);
               }
            }
            else
            {
               _loc3_ = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_024).DescribeString;
               FOnBuyBox(TProcessorWing.TRANSFORM_WING,0,this.FCurWing.Identifier,0,_loc3_,1,0,1);
            }
         }
      }
      
      protected function ProcessorOnHideUp(param1:MouseEvent) : void
      {
         if(FOnGetBox != null && Boolean(this.FWing))
         {
            if(this.FWing.HideWing == 1)
            {
               FOnGetBox(TProcessorWing.HIDE_WING,2);
            }
            else
            {
               FOnGetBox(TProcessorWing.HIDE_WING,1);
            }
         }
      }
      
      protected function ProcessorOnChangePage(param1:Object, param2:int) : void
      {
         this.FPageIndex = param2;
         this.FWingIndex = param2 * TAB_COUNT;
         this.FUITab.Reset();
         this.UpdateTab();
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
            if(this.FCurWing)
            {
               this.UpdateWingEffect();
               if(this.FCurWing.duration == 0)
               {
                  this.FTF_Time.text = STRING_TITLE.STRING_Forever;
               }
               else
               {
                  _loc2_ = this.FWing.GetWingTransformTimeByID(this.FCurWing.Identifier);
                  this.FTF_Time.text = this.FWing.GetWingTransformCountByID(this.FCurWing.Identifier) < this.FCurWing.activatetime ? TUtilityString.Format(new ConsumeFrameCopy(STRING_WING.WINGS_STRING_028).DescribeString,this.FCurWing.duration * this.FWing.GetWingTransformCountByID(this.FCurWing.Identifier),TGameUtil.fomatTime(_loc2_ - STimingCore.GetServerTick())) : STRING_TITLE.STRING_Forever;
               }
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FWing.UpdateWings();
         this.UpdateTab();
      }
      
      override public function Unmount() : void
      {
      }
   }
}

