package Processors.Game.Lobby.Smithy
{
   import Components.Standard.*;
   import Foundation.Common.THint;
   import Foundation.Resources.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.*;
   import Logics.SLogicsCore;
   import Logics.Smithy.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.*;
   import Resources.Strings.STRING_SMITHY;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.*;
   import flash.events.*;
   
   public class TProcessorWindowSmithy extends TProcessorLobbyWindow
   {
      
      protected static const TAB_INDEX_STRENGTHEN:int = 0;
      
      protected static const TAB_INDEX_REFINED:int = 1;
      
      protected static const TAB_INDEX_INHERIT:int = 2;
      
      protected static const TAB_INDEX_PUNCH:int = 3;
      
      protected static const TAB_INDEX_ENCHANT:int = 4;
      
      protected static const TAB_INDEX_MAKEEQUIP:int = 5;
      
      protected static const TAB_INDEX_UPGRADE:int = 6;
      
      protected var FHelpTips:THint;
      
      protected var FUI_Smithy:MovieClip;
      
      protected var FWindowEquip:SmithyWindowEquipShow;
      
      protected var FWindowStrengthen:SmithyWindowStrengthen;
      
      protected var FWindowRefined:SmithyWindowRefined;
      
      protected var FWindowInherit:SmithyWindowInherit;
      
      protected var FWindowPunch:SmithyWindowPunch;
      
      protected var FWindowEnchant:SmithyWindowEnchant;
      
      protected var FWindowMakeEquip:SmithyWindowMakeEquip;
      
      protected var FWindowUpgrade:SmithyWindowUpgrade;
      
      protected var FWindows:Vector.<TProcessorLobbyWindow>;
      
      protected var FTabs:TUITab;
      
      protected var FMC_PendantLeft:MovieClip;
      
      protected var FMC_PendantRight:MovieClip;
      
      protected var FCurrentVisibleWindowIndex:int;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FBtn_Help:SimpleButton;
      
      protected var FDigHole_OpenLevel:uint;
      
      protected var FEnchant_OpenLevel:uint;
      
      protected var FHint:THint;
      
      protected var FMakeConfirmation:TUIWindowConfirmation;
      
      protected var FUIComponentsBtnOnOver:Function;
      
      protected var FUIComponentsBtnOnOut:Function;
      
      protected var FOnHelpTipsOver:Function;
      
      protected var FOnHelpTipsOut:Function;
      
      public function TProcessorWindowSmithy(param1:TUIComponent)
      {
         super(param1);
         this.FHelpTips = new THint();
         this.FHint = new THint();
         this.FWindowStrengthen = new SmithyWindowStrengthen(this);
         this.FWindowStrengthen.BackReset = this.BackReset;
         this.FWindowEquip = new SmithyWindowEquipShow(this);
         this.FWindowRefined = new SmithyWindowRefined(this);
         this.FWindowRefined.BackReset = this.BackReset;
         this.FWindowInherit = new SmithyWindowInherit(this);
         this.FWindowInherit.BackReset = this.BackReset;
         this.FWindowPunch = new SmithyWindowPunch(this);
         this.FWindowPunch.BackReset = this.BackReset;
         this.FWindowEnchant = new SmithyWindowEnchant(this);
         this.FWindowEnchant.BackReset = this.BackReset;
         this.FWindowMakeEquip = new SmithyWindowMakeEquip(this);
         this.FWindowUpgrade = new SmithyWindowUpgrade(this);
         this.FWindowUpgrade.BackReset = this.BackReset;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_SMITHY.RESOURCESID_SMITHY);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         var _loc3_:Vector.<String> = null;
         var _loc4_:int = 0;
         var _loc5_:TConfigValue = null;
         this.FUI_Smithy = TUtilityReflection.CreateDisplayObjectInstance(CONST_SMITHY.RESOURCESID_ClassName_Strengthen) as MovieClip;
         addChild(this.FUI_Smithy);
         addChild(this.FWindowStrengthen);
         this.FUI_Smithy.gotoAndStop("FrameStrengthen");
         this.FWindowStrengthen.Perform_UIDispatch(this.FUI_Smithy["UIStrengthen"]);
         addChild(this.FWindowEquip);
         this.FWindowEquip.Perform_UIDispatch(this.FUI_Smithy["MainUI"]);
         addChild(this.FWindowRefined);
         this.FUI_Smithy.gotoAndStop("FrameRefined");
         this.FWindowRefined.Perform_UIDispatch(this.FUI_Smithy["UIRefined"]);
         addChild(this.FWindowInherit);
         this.FUI_Smithy.gotoAndStop("FrameInherit");
         this.FWindowInherit.Perform_UIDispatch(this.FUI_Smithy["UIInherit"]);
         addChild(this.FWindowPunch);
         this.FUI_Smithy.gotoAndStop("FramePunch");
         this.FWindowPunch.Perform_UIDispatch(this.FUI_Smithy["UIPunch"]);
         addChild(this.FWindowEnchant);
         this.FUI_Smithy.gotoAndStop("FrameEnchant");
         this.FWindowEnchant.Perform_UIDispatch(this.FUI_Smithy["UIEnchant"]);
         addChild(this.FWindowUpgrade);
         this.FUI_Smithy.gotoAndStop("FrameUpgrade");
         this.FWindowUpgrade.Perform_UIDispatch(this.FUI_Smithy["UIUpgrade"]);
         addChild(this.FWindowMakeEquip);
         this.FUI_Smithy.gotoAndStop("FrameMakeEquip");
         this.FWindowMakeEquip.Perform_UIDispatch(this.FUI_Smithy["UIMakeEquip"]);
         this.FWindowMakeEquip.ShowMakeConfirmation = this.ShowMakeConfirmation;
         this.FWindows = new Vector.<TProcessorLobbyWindow>();
         this.FWindows.push(this.FWindowStrengthen);
         this.FWindows.push(this.FWindowRefined);
         this.FWindows.push(this.FWindowInherit);
         this.FWindows.push(this.FWindowPunch);
         this.FWindows.push(this.FWindowEnchant);
         this.FWindows.push(this.FWindowMakeEquip);
         this.FWindows.push(this.FWindowUpgrade);
         this.FTabs = new TUITab(this);
         _loc3_ = CONST_SMITHY.Tab_Names;
         _loc4_ = int(_loc3_.length);
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc1_ = this.FUI_Smithy[_loc3_[_loc2_]];
            _loc1_.buttonMode = true;
            _loc1_.mouseChildren = false;
            this.FTabs.SetTabByIndex(_loc1_,_loc2_);
            _loc2_++;
         }
         this.FTabs.OnSwitch = this.TabClick;
         this.FTabs.Init();
         this.FBtn_Close = this.FUI_Smithy["MainUI"]["StrengthenClose"];
         this.FBtn_Help = this.FUI_Smithy["MainUI"]["StrengthenHelp"];
         this.FMC_PendantLeft = this.FUI_Smithy["MC_PendantLeft"];
         this.FMC_PendantRight = this.FUI_Smithy["MC_PendantRight"];
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Smithy_DigHole_OpenLevel) as TConfigValue;
         this.FDigHole_OpenLevel = _loc5_.Value as uint;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Smithy_Enchant_OpenLevel) as TConfigValue;
         this.FEnchant_OpenLevel = _loc5_.Value as uint;
         this.FMakeConfirmation = new TUIWindowConfirmation(this.Parent.Parent);
         TUtilityUIWindow.SetupWindowConfirmation(this.FMakeConfirmation);
         this.FMakeConfirmation.x = (FUICore.StageWidth - this.FMakeConfirmation.WindowWidth) / 2;
         this.FMakeConfirmation.y = (FUICore.StageHeight - this.FMakeConfirmation.WindowHeight) / 2;
         this.FMakeConfirmation.OnOK = this.OnAdvMake;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FWindowEquip.Perform_UILocation();
         this.FWindowEquip.visible = true;
         this.FWindowEquip.OnEquipmentClick = this.OnEquipmentClick;
         this.FWindowStrengthen.Perform_UILocation();
         this.FWindowRefined.Perform_UILocation();
         this.FWindowInherit.Perform_UILocation();
         this.FWindowPunch.Perform_UILocation();
         this.FWindowEnchant.Perform_UILocation();
         this.FWindowMakeEquip.Perform_UILocation();
         this.FWindowUpgrade.Perform_UILocation();
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.OnCloseWindow);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         if(SLogicsCore.Character.GetMainLevel() < this.FDigHole_OpenLevel)
         {
            this.FTabs.SetTabEnabledByIndex(TAB_INDEX_PUNCH,false);
         }
         if(SLogicsCore.Character.GetMainLevel() < this.FEnchant_OpenLevel)
         {
            this.FTabs.SetTabEnabledByIndex(TAB_INDEX_ENCHANT,false);
         }
         this.FTabs.OnOver = this.UITabOnOver;
         this.FTabs.OnOut = this.UITabOnOut;
         this.SwitchTab(TAB_INDEX_STRENGTHEN);
         super.ResourcesPerform_UILocations();
      }
      
      protected function SwitchTab(param1:int) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         this.FWindowEquip.Visible = false;
         this.FWindowMakeEquip.Visible = false;
         _loc3_ = 0;
         while(_loc3_ < CONST_SMITHY.SMITHY_TAB_NUM)
         {
            this.FWindows[_loc3_].Visible = false;
            _loc3_++;
         }
         if(param1 != TAB_INDEX_MAKEEQUIP)
         {
            this.FWindowEquip.Visible = true;
            this.FWindows[param1].Visible = true;
            this.FWindowEquip.SetTabIndex(param1);
         }
         else
         {
            this.FWindowMakeEquip.Visible = true;
            this.FWindowMakeEquip.Update();
         }
         this.FCurrentVisibleWindowIndex = param1;
      }
      
      protected function Reset() : void
      {
         this.FTabs.SwithTagManual(TAB_INDEX_STRENGTHEN);
         this.FWindowEquip.Reset();
      }
      
      protected function BackReset() : void
      {
         this.FWindowEquip.BackReset();
      }
      
      protected function OnEquipmentClick(param1:TEquipment, param2:uint) : void
      {
         switch(this.FCurrentVisibleWindowIndex)
         {
            case TAB_INDEX_STRENGTHEN:
               this.FWindowStrengthen.ReciveEquipment(param1,param2);
               break;
            case TAB_INDEX_REFINED:
               this.FWindowRefined.ReciveEquipment(param1,param2);
               this.FWindowRefined.Update();
               break;
            case TAB_INDEX_INHERIT:
               this.FWindowInherit.ReciveEquipment(param1,param2);
               this.FWindowInherit.Update();
               break;
            case TAB_INDEX_PUNCH:
               this.FWindowPunch.ReciveEquipment(param1,param2);
               this.FWindowPunch.Update();
               break;
            case TAB_INDEX_ENCHANT:
               this.FWindowEnchant.ReciveEquipment(param1,param2);
               this.FWindowEnchant.Update();
               break;
            case TAB_INDEX_UPGRADE:
               this.FWindowUpgrade.ReciveEquipment(param1,param2);
               this.FWindowUpgrade.Update();
         }
      }
      
      protected function ShowMakeConfirmation(param1:String) : void
      {
         this.FMakeConfirmation.Text = param1;
         this.FMakeConfirmation.Visible = true;
      }
      
      protected function OnAdvMake(param1:Object) : void
      {
         this.FWindowMakeEquip.AdvMakeEquip();
      }
      
      protected function TabClick(param1:Object) : void
      {
         this.SwitchTab(param1 as int);
      }
      
      protected function OnCloseWindow(param1:MouseEvent) : void
      {
         this.Reset();
         ProcessorWindowClose();
         this.StopPendant();
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(this.FOnHelpTipsOver != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_Smithy) as TSystemLanguage;
            this.FHelpTips.Content = _loc2_.Desc;
            this.FOnHelpTipsOver(this,this.FHelpTips);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(this.FOnHelpTipsOut != null)
         {
            this.FOnHelpTipsOut(this);
         }
      }
      
      protected function UITabOnOver(param1:Object, param2:uint, param3:Boolean) : void
      {
         var _loc4_:TUITab = null;
         var _loc5_:MovieClip = null;
         var _loc6_:String = null;
         _loc4_ = param1 as TUITab;
         _loc5_ = _loc4_.GetTabByIndex(param2);
         if(_loc5_.currentFrame != TUITab.RENDERINGSTATE_Disabled)
         {
            return;
         }
         if(!param3)
         {
            if(param2 == TAB_INDEX_PUNCH)
            {
               _loc6_ = STRING_SMITHY.STRING_DigHoleLimit;
               _loc6_ = _loc6_.split("%level%").join(this.FDigHole_OpenLevel);
               this.FHint.Caption = _loc6_;
               if(this.FUIComponentsBtnOnOver != null)
               {
                  this.FUIComponentsBtnOnOver(this,this.FHint);
               }
            }
            else if(param2 == TAB_INDEX_ENCHANT)
            {
               _loc6_ = STRING_SMITHY.STRING_EnchantLimit;
               _loc6_ = _loc6_.split("%level%").join(this.FEnchant_OpenLevel);
               this.FHint.Caption = _loc6_;
               if(this.FUIComponentsBtnOnOver != null)
               {
                  this.FUIComponentsBtnOnOver(this,this.FHint);
               }
            }
         }
      }
      
      protected function UITabOnOut(param1:Object, param2:uint, param3:Boolean) : void
      {
         if(!param3 && param2 == TAB_INDEX_PUNCH)
         {
            if(this.FUIComponentsBtnOnOut != null)
            {
               this.FUIComponentsBtnOnOut(this);
            }
         }
         else if(!param3 && param2 == TAB_INDEX_ENCHANT)
         {
            if(this.FUIComponentsBtnOnOut != null)
            {
               this.FUIComponentsBtnOnOut(this);
            }
         }
      }
      
      public function set StrengthenNetWork(param1:Function) : void
      {
         this.FWindowStrengthen.StrengthenNetwork = param1;
      }
      
      public function set StrengthenLevel(param1:int) : void
      {
         this.FWindowStrengthen.StrengthenLevel = param1;
      }
      
      public function set StrengthenCDTime(param1:uint) : void
      {
         this.FWindowStrengthen.StrengthenCDTime = param1;
      }
      
      public function set StrengthenColdTimeRequest(param1:Function) : void
      {
         this.FWindowStrengthen.StrengthenColdTimeRequest = param1;
      }
      
      public function set RefinedNetwork(param1:Function) : void
      {
         this.FWindowRefined.RefinedNetwork = param1;
      }
      
      public function set RefinedExchange(param1:Function) : void
      {
         this.FWindowRefined.RefinedExchange = param1;
      }
      
      public function set CurrentSmithyAttributeList(param1:TSmithyRefinedPakcetUnstreamizerData) : void
      {
         this.FWindowRefined.CurrentSmithyAttributeList = param1;
      }
      
      public function set InheritNetwork(param1:Function) : void
      {
         this.FWindowInherit.InheritNetwork = param1;
      }
      
      public function set PunchNetwork(param1:Function) : void
      {
         this.FWindowPunch.PunchNetwork = param1;
      }
      
      public function set EnchantNewwork(param1:Function) : void
      {
         this.FWindowEnchant.EnchantNetwork = param1;
      }
      
      public function set MakeEquipNewwork(param1:Function) : void
      {
         this.FWindowMakeEquip.MakeEquipNetwork = param1;
      }
      
      public function set UpgradeNetwork(param1:Function) : void
      {
         this.FWindowUpgrade.UpgradeNetwork = param1;
      }
      
      public function set ICMove(param1:Function) : void
      {
         this.FWindowStrengthen.ICMove = param1;
      }
      
      public function get KaguyState() : Boolean
      {
         return this.FWindowStrengthen.KaguyState;
      }
      
      public function set ICOut(param1:Function) : void
      {
         this.FWindowStrengthen.ICOut = param1;
      }
      
      public function set UIComponentsHintOnOver(param1:Function) : void
      {
         this.FWindowEquip.OnSlotMouseOver = param1;
         this.FWindowStrengthen.OnSlotMouseOver = param1;
         this.FWindowRefined.OnSlotMouseOver = param1;
         this.FWindowInherit.OnSlotMouseOver = param1;
         this.FWindowPunch.OnSlotMouseOver = param1;
         this.FWindowEnchant.OnSlotMouseOver = param1;
         this.FWindowMakeEquip.OnSlotMouseOver = param1;
         this.FWindowUpgrade.OnSlotMouseOver = param1;
      }
      
      public function set UIComponentsHintOnOut(param1:Function) : void
      {
         this.FWindowEquip.OnSlotMouseOut = param1;
         this.FWindowStrengthen.OnSlotMouseOut = param1;
         this.FWindowRefined.OnSlotMouseOut = param1;
         this.FWindowInherit.OnSlotMouseOut = param1;
         this.FWindowPunch.OnSlotMouseOut = param1;
         this.FWindowEnchant.OnSlotMouseOut = param1;
         this.FWindowMakeEquip.OnSlotMouseOut = param1;
         this.FWindowUpgrade.OnSlotMouseOut = param1;
      }
      
      override public function set OnEffectText(param1:Function) : void
      {
         super.OnEffectText = param1;
         this.FWindowStrengthen.OnEffectText = param1;
         this.FWindowRefined.OnEffectText = param1;
         this.FWindowInherit.OnEffectText = param1;
         this.FWindowPunch.OnEffectText = param1;
         this.FWindowEnchant.OnEffectText = param1;
         this.FWindowMakeEquip.OnEffectText = param1;
         this.FWindowUpgrade.OnEffectText = param1;
      }
      
      public function set ResultCode(param1:uint) : void
      {
         switch(this.FCurrentVisibleWindowIndex)
         {
            case TAB_INDEX_STRENGTHEN:
               this.FWindowStrengthen.StrengthenResult = param1;
               break;
            case TAB_INDEX_REFINED:
               this.FWindowRefined.StrengthenResult = param1;
               break;
            case TAB_INDEX_INHERIT:
               this.FWindowInherit.StrengthenResult = param1;
               break;
            case TAB_INDEX_PUNCH:
               this.FWindowPunch.StrengthenResult = param1;
               break;
            case TAB_INDEX_ENCHANT:
               this.FWindowEnchant.StrengthenResult = param1;
               break;
            case TAB_INDEX_MAKEEQUIP:
               this.FWindowMakeEquip.StrengthenResult = param1;
               break;
            case TAB_INDEX_UPGRADE:
               this.FWindowUpgrade.StrengthenResult = param1;
         }
      }
      
      public function set ClearTime(param1:Function) : void
      {
         this.FWindowStrengthen.OnClearTime = param1;
      }
      
      public function get OnHelpTipsOver() : Function
      {
         return this.FOnHelpTipsOver;
      }
      
      public function set OnHelpTipsOver(param1:Function) : void
      {
         this.FOnHelpTipsOver = param1;
      }
      
      public function get OnHelpTipsOut() : Function
      {
         return this.FOnHelpTipsOut;
      }
      
      public function set OnHelpTipsOut(param1:Function) : void
      {
         this.FOnHelpTipsOut = param1;
      }
      
      public function set UpdateHeroPower(param1:Function) : void
      {
         this.FWindowStrengthen.UpdateHeroPower = param1;
         this.FWindowRefined.UpdateHeroPower = param1;
         this.FWindowEnchant.UpdateHeroPower = param1;
      }
      
      public function UpdateFreeCount() : void
      {
         this.FWindowStrengthen.UpdateFreeCount();
      }
      
      public function set UpdateHerosPower(param1:Function) : void
      {
         this.FWindowInherit.UpdateHerosPower = param1;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FWindowEnchant.OnShortcutHyperlinks = param1;
      }
      
      public function set UIComponentsBtnOnOver(param1:Function) : void
      {
         this.FUIComponentsBtnOnOver = param1;
         this.FWindowStrengthen.HintOnOver = param1;
         this.FWindowRefined.HintOnOver = param1;
         this.FWindowInherit.HintOnOver = param1;
         this.FWindowPunch.HintOnOver = param1;
         this.FWindowEnchant.HintOnOver = param1;
         this.FWindowMakeEquip.HintOnOver = param1;
         this.FWindowUpgrade.HintOnOver = param1;
      }
      
      public function set UIComponentsBtnOnOut(param1:Function) : void
      {
         this.FUIComponentsBtnOnOut = param1;
         this.FWindowStrengthen.HintOnOut = param1;
         this.FWindowRefined.HintOnOut = param1;
         this.FWindowInherit.HintOnOut = param1;
         this.FWindowPunch.HintOnOut = param1;
         this.FWindowEnchant.HintOnOut = param1;
         this.FWindowMakeEquip.HintOnOut = param1;
         this.FWindowUpgrade.HintOnOut = param1;
      }
      
      public function Update() : void
      {
         if(SLogicsCore.Character.GetMainLevel() >= this.FDigHole_OpenLevel && this.FCurrentVisibleWindowIndex != TAB_INDEX_PUNCH)
         {
            this.FTabs.GetTabByIndex(TAB_INDEX_PUNCH).gotoAndStop(TUITab.RENDERINGSTATE_UnSelect);
         }
         if(SLogicsCore.Character.GetMainLevel() >= this.FEnchant_OpenLevel && this.FCurrentVisibleWindowIndex != TAB_INDEX_ENCHANT)
         {
            this.FTabs.GetTabByIndex(TAB_INDEX_ENCHANT).gotoAndStop(TUITab.RENDERINGSTATE_UnSelect);
         }
         switch(this.FCurrentVisibleWindowIndex)
         {
            case TAB_INDEX_STRENGTHEN:
               this.FWindowStrengthen.Update();
               break;
            case TAB_INDEX_REFINED:
               this.FWindowRefined.Update();
               break;
            case TAB_INDEX_INHERIT:
               this.FWindowInherit.Update();
               break;
            case TAB_INDEX_PUNCH:
               this.FWindowPunch.Update();
               break;
            case TAB_INDEX_ENCHANT:
               this.FWindowEnchant.Update();
               break;
            case TAB_INDEX_MAKEEQUIP:
               this.FWindowMakeEquip.Update();
               break;
            case TAB_INDEX_UPGRADE:
               this.FWindowUpgrade.Update();
         }
         this.FWindowEquip.Update();
         this.FWindowStrengthen.OpenUpdate();
      }
      
      public function SetTabIndex(param1:uint) : void
      {
         this.SwitchTab(param1);
         this.FTabs.TabIndex = param1;
         if(SLogicsCore.Character.GetMainLevel() < this.FDigHole_OpenLevel)
         {
            this.FTabs.SetTabEnabledByIndex(TAB_INDEX_PUNCH,false);
         }
         if(SLogicsCore.Character.GetMainLevel() < this.FEnchant_OpenLevel)
         {
            this.FTabs.SetTabEnabledByIndex(TAB_INDEX_ENCHANT,false);
         }
      }
      
      public function ShackPendant() : void
      {
         this.FMC_PendantLeft.gotoAndPlay(1);
         this.FMC_PendantRight.gotoAndPlay(1);
      }
      
      public function StopPendant() : void
      {
         this.FMC_PendantLeft.gotoAndStop(1);
         this.FMC_PendantRight.gotoAndStop(1);
      }
      
      public function VipLevelUpCheckBtnStatus() : void
      {
         this.FWindowMakeEquip.VipLevelUpCheckBtnStatus();
      }
      
      public function FromNewMallMessage(param1:int) : void
      {
         this.FWindowEnchant.FromNewMallMessage(param1);
      }
   }
}

