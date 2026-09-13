package Processors.Game.Lobby.Jade
{
   import Components.Standard.*;
   import Foundation.Common.THint;
   import Foundation.Registries.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Strings.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowJade extends TProcessorLobbyWindow
   {
      
      protected static const TabMosaicIndex:int = 0;
      
      protected static const TabCombineIndex:int = 1;
      
      protected var FHelpTips:THint;
      
      protected var FScene:MovieClip;
      
      protected var FMosaicScene:TJadeMosaic;
      
      protected var FCombineScene:TJadeCombin;
      
      protected var FJadeJinHua:TJadeJinHua;
      
      protected var FJadeShengXing:TJadeShengXing;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBtn_Help:SimpleButton;
      
      protected var IndexArr:Array;
      
      protected var FCurrentTabIndex:int;
      
      protected var FUITab:TUITab;
      
      protected var FTextRegistry:TRegistryInstance;
      
      protected var FMC_PendantLeft:MovieClip;
      
      protected var FMC_PendantRight:MovieClip;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      protected var FOnInventoryOverCopy:Function;
      
      protected var FOnInventoryOutCopy:Function;
      
      protected var FOnHelpTipsOver:Function;
      
      protected var FOnHelpTipsOut:Function;
      
      protected var FOnUpdatePower:Function;
      
      protected var FJinHuaBackFunction:Function;
      
      protected var FTunShiBackFucntion:Function;
      
      protected var FOnHintOver:Function;
      
      protected var FOnHintOut:Function;
      
      public var EffectGenerateTextByErrorCode:Function;
      
      public function TProcessorWindowJade(param1:TUIComponent)
      {
         super(param1);
         this.FHelpTips = new THint();
         this.FUITab = new TUITab(this);
         this.IndexArr = new Array(2,3);
         this.ConstructFlyText();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_JADE.RESOURCESID_JADE);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_JADE.RESOURCE_ClassName_JADE) as MovieClip;
         addChild(this.FScene);
         this.FMosaicScene = new TJadeMosaic(this);
         this.FMosaicScene.OnInventoryOver = this.ProcessorInventoryOnOver;
         this.FMosaicScene.OnInventoryOut = this.ProcessorInventoryOnOut;
         this.FMosaicScene.FlyText = this.FlyText;
         this.FCombineScene = new TJadeCombin(this);
         this.FCombineScene.OnInventoryOver = this.ProcessorInventoryOnOver;
         this.FCombineScene.OnInventoryOut = this.ProcessorInventoryOnOut;
         this.FCombineScene.FlyText = this.FlyText;
         this.FMosaicScene.Perform_UIDispatch(this.FScene["MC_MosaicView"]);
         this.FMosaicScene.visible = false;
         this.FMosaicScene.UpdateHeroPower = this.UpdatePower;
         this.FScene.gotoAndStop("combine");
         this.FCombineScene.Perform_UIDispatch(this.FScene["MC_CombineView"]);
         this.FCombineScene.visible = false;
         this.FJadeJinHua = new TJadeJinHua(this);
         this.FJadeJinHua.OnInventoryOver = this.ProcessorInventoryOnOver;
         this.FJadeJinHua.OnInventoryOut = this.ProcessorInventoryOnOut;
         this.FJadeJinHua.JinHuaBackFunction = this.JinHuaBackFunctionClick;
         this.FJadeJinHua.FlyText = this.FlyTextCopy;
         this.FJadeJinHua.UpdateHeroPower = this.UpdatePower;
         this.FJadeShengXing = new TJadeShengXing(this);
         this.FJadeShengXing.OnInventoryOver = this.ProcessorInventoryOnOver;
         this.FJadeShengXing.OnInventoryOut = this.ProcessorInventoryOnOut;
         this.FJadeShengXing.OnInventoryOverCopy = this.ProcessorInventoryOnOverCopy;
         this.FJadeShengXing.OnInventoryOutCopy = this.ProcessorInventoryOnOutCopy;
         this.FJadeShengXing.TunShiBackFucntion = this.TunShiBackFucntionClick;
         this.FJadeShengXing.FlyText = this.FlyTextCopy;
         this.FJadeShengXing.EffectGenerateTextByErrorCode = this.EffectGenerateTextByErrorCode;
         this.FJadeJinHua.UpdateHeroPower = this.UpdatePower;
         this.FScene.gotoAndStop("JinHua");
         this.FJadeJinHua.Perform_UIDispatch(this.FScene["MC_JadeJinHua"]);
         this.FJadeJinHua.visible = false;
         this.FScene.gotoAndStop("ShengXing");
         this.FJadeShengXing.Perform_UIDispatch(this.FScene["MC_JadeShengXing"]);
         this.FJadeShengXing.visible = false;
         this.FBTN_Close = this.FScene["btn_close"];
         this.FBtn_Help = this.FScene["btn_help"];
         _loc2_ = 4;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FUITab.SetTabByIndex(this.FScene[CONST_JADE.JadeBtn[_loc1_]],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.SwitchTab;
         this.FUITab.OnOver = this.ProcessorTabOnOver;
         this.FUITab.OnOut = this.ProcessorTabOnOut;
         this.FUITab.Init();
         this.FMosaicScene.OnEffectText = FOnEffectText;
         this.FCombineScene.OnEffectText = FOnEffectText;
         this.FMC_PendantLeft = this.FScene["MC_PendantLeft"];
         this.FMC_PendantRight = this.FScene["MC_PendantRight"];
         super.ResourcesPerform_UIDispatch();
      }
      
      public function UpdateTable() : void
      {
         if(SLogicsCore.Character.MainHero.Level >= SLogicsCore.LostShenQiLogicData.SuperJadeShowLevel)
         {
            this.FUITab.NiMeijiaQiang(null);
            if(SLogicsCore.Character.MainHero.Level >= SLogicsCore.LostShenQiLogicData.SuperJadeOpenLevel)
            {
               this.FUITab.SetTabOpenByIndex(2,true);
               this.FUITab.SetTabOpenByIndex(3,true);
            }
            else
            {
               this.FUITab.SetTabEnabledByIndex(2,false);
               this.FUITab.SetTabEnabledByIndex(3,false);
            }
         }
         else
         {
            this.FUITab.NiMeijiaQiang(this.IndexArr);
         }
      }
      
      protected function ProcessorTabOnOver(param1:Object, param2:int, param3:Boolean) : void
      {
         if(param2 != 2 && param2 != 3 || param3)
         {
            return;
         }
         this.FHelpTips.Caption = TUtilityString.Format(new ConsumeFrame(70107010).DescribeString,SLogicsCore.LostShenQiLogicData.SuperJadeOpenLevel);
         if(this.FOnHintOver != null)
         {
            this.FOnHintOver(this,this.FHelpTips);
         }
      }
      
      protected function ProcessorTabOnOut(param1:Object, param2:int, param3:Boolean) : void
      {
         if(this.FOnHintOut != null)
         {
            this.FOnHintOut(this);
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FScene.btn_close.addEventListener(MouseEvent.CLICK,this.OnCloseWindow);
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.OnCloseWindow);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         this.FMosaicScene.Perform_UILocation();
         this.FCombineScene.Perform_UILocation();
         this.FJadeJinHua.Perform_UILocation();
         this.FJadeShengXing.Perform_UILocation();
         this.Perform_Reset();
         super.ResourcesPerform_UILocations();
      }
      
      protected function ProcessorInventoryOnOverCopy(param1:Object) : void
      {
         if(this.FOnInventoryOverCopy != null)
         {
            this.FOnInventoryOverCopy(param1);
         }
      }
      
      protected function ProcessorInventoryOnOutCopy(param1:Object) : void
      {
         if(this.FOnInventoryOutCopy != null)
         {
            this.FOnInventoryOutCopy(param1);
         }
      }
      
      protected function ProcessorInventoryOnOver(param1:Object, param2:Object) : void
      {
         if(this.FOnInventoryOver != null)
         {
            this.FOnInventoryOver(this,param2);
         }
      }
      
      protected function ProcessorInventoryOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnInventoryOut != null)
         {
            this.FOnInventoryOut(this,param2);
         }
      }
      
      public function JicHuaS_C() : void
      {
         this.FJadeJinHua.JicHuaS_C();
      }
      
      public function ShenJiS_C(param1:ByteArray) : void
      {
         this.FJadeShengXing.ShenJiS_C(param1);
      }
      
      protected function SwitchTab(param1:Object) : void
      {
         if(param1 is int)
         {
            this.FCurrentTabIndex = param1 as int;
            this.FMosaicScene.visible = false;
            this.FCombineScene.visible = false;
            this.FJadeShengXing.visible = false;
            this.FJadeJinHua.visible = false;
            switch(this.FCurrentTabIndex)
            {
               case 0:
                  this.FCurrentTabIndex = TabMosaicIndex;
                  this.Update();
                  this.FMosaicScene.visible = true;
                  break;
               case 1:
                  this.FCurrentTabIndex = TabCombineIndex;
                  this.Update();
                  this.FCombineScene.visible = true;
                  break;
               case 2:
                  this.FCurrentTabIndex = 2;
                  this.FJadeJinHua.visible = true;
                  this.FJadeJinHua.OpenThisPanel();
                  break;
               case 3:
                  this.FCurrentTabIndex = 3;
                  this.FJadeShengXing.visible = true;
                  this.FJadeShengXing.OpenThisPanel();
            }
            this.FUITab.SwithTagManual(this.FCurrentTabIndex);
         }
      }
      
      protected function StopPendant() : void
      {
         this.FMC_PendantLeft.gotoAndStop(1);
         this.FMC_PendantRight.gotoAndStop(1);
      }
      
      protected function Perform_Reset() : void
      {
         this.SwitchTab(0);
      }
      
      protected function ConstructFlyText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Vector.<String> = null;
         this.FTextRegistry = new TRegistryInstance();
         _loc3_ = STRING_JADE.STRENGTHEN_FLYTEXTS;
         _loc2_ = int(_loc3_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FTextRegistry.Register(STRING_JADE.JADE_TEXTIDS[_loc1_],STRING_JADE.STRENGTHEN_FLYTEXTS[_loc1_]);
            _loc1_++;
         }
      }
      
      protected function FlyTextCopy(param1:String) : void
      {
         EffectGenerateText(param1);
      }
      
      protected function FlyText(param1:int) : void
      {
         var _loc2_:String = null;
         _loc2_ = this.FTextRegistry.GetInstanceByIdentifier(param1) as String;
         EffectGenerateText(_loc2_);
      }
      
      protected function OnCloseWindow(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
         this.Reset();
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(this.FOnHelpTipsOver != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_Jade) as TSystemLanguage;
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
      
      protected function UpdatePower(param1:Object, param2:uint) : void
      {
         if(this.FOnUpdatePower != null)
         {
            this.FOnUpdatePower(param1,param2);
         }
      }
      
      protected function JinHuaBackFunctionClick(param1:TInventory, param2:TInventory, param3:uint) : void
      {
         if(this.FJinHuaBackFunction != null)
         {
            this.FJinHuaBackFunction(param1,param2,param3);
         }
      }
      
      protected function TunShiBackFucntionClick(param1:TInventory, param2:TInventory, param3:uint, param4:uint) : void
      {
         if(this.FTunShiBackFucntion != null)
         {
            this.FTunShiBackFucntion(param1,param2,param3,param4);
         }
      }
      
      public function set TunShiBackFucntion(param1:Function) : void
      {
         this.FTunShiBackFucntion = param1;
      }
      
      public function set JinHuaBackFunction(param1:Function) : void
      {
         this.FJinHuaBackFunction = param1;
      }
      
      public function set OnInventoryOverCopy(param1:Function) : void
      {
         this.FOnInventoryOverCopy = param1;
      }
      
      public function set OnInventoryOutCopy(param1:Function) : void
      {
         this.FOnInventoryOutCopy = param1;
      }
      
      public function set OnInventoryOver(param1:Function) : void
      {
         this.FOnInventoryOver = param1;
      }
      
      public function set OnInventoryOut(param1:Function) : void
      {
         this.FOnInventoryOut = param1;
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
      
      public function set OnMountJade(param1:Function) : void
      {
         this.FMosaicScene.OnMountJade = param1;
      }
      
      public function set OnUnmountJade(param1:Function) : void
      {
         this.FMosaicScene.OnUnmountJade = param1;
      }
      
      public function set OneKeyOnUnmountJade(param1:Function) : void
      {
         this.FMosaicScene.OneKeyOnUnmountJade = param1;
      }
      
      public function set OnCombine(param1:Function) : void
      {
         this.FCombineScene.OnCombine = param1;
      }
      
      public function set OnHintOver(param1:Function) : void
      {
         this.FOnHintOver = param1;
      }
      
      public function set OnHintOut(param1:Function) : void
      {
         this.FOnHintOut = param1;
      }
      
      public function set ResultCode(param1:uint) : void
      {
         switch(this.FCurrentTabIndex)
         {
            case TabMosaicIndex:
               this.FMosaicScene.ResultCode = param1;
               break;
            case TabCombineIndex:
               this.FCombineScene.ResultCode = param1;
         }
      }
      
      override public function set OnEffectText(param1:Function) : void
      {
         FOnEffectText = param1;
      }
      
      public function set UpdateHeroPower(param1:Function) : void
      {
         this.FOnUpdatePower = param1;
      }
      
      public function Update() : void
      {
         switch(this.FCurrentTabIndex)
         {
            case TabMosaicIndex:
               this.FMosaicScene.Update();
               break;
            case TabCombineIndex:
               this.FCombineScene.Update();
         }
      }
      
      public function Reset() : void
      {
         this.Perform_Reset();
         this.FMosaicScene.Reset();
         this.FCombineScene.Reset();
         this.StopPendant();
      }
      
      public function ShackPendant() : void
      {
         this.FMC_PendantLeft.gotoAndPlay(1);
         this.FMC_PendantRight.gotoAndPlay(1);
      }
   }
}

