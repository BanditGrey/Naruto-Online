package Processors.Game.Lobby.CrossServerWar
{
   import Foundation.Common.THint;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.CrossServerWar.TEliteRecord;
   import Logics.CrossServerWar.TIntegralRankings;
   import Logics.CrossServerWar.TOrangeInventorySample;
   import Logics.CrossServerWar.TOrangeInventorySamples;
   import Logics.CrossServerWar.TTokenInventorySample;
   import Logics.CrossServerWar.TTokenInventorySamples;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.DatebaseVO.VO.TGSPVP_DailyAward;
   import Logics.DatebaseVO.VO.TTavernWarrior;
   import Logics.Inventories.TInventoryReference;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventorySamples;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.CrossServerWar.Window.TProcessorWindowChallengeRankings;
   import Processors.Game.Lobby.CrossServerWar.Window.TProcessorWindowCheers;
   import Processors.Game.Lobby.CrossServerWar.Window.TProcessorWindowExplanation;
   import Processors.Game.Lobby.CrossServerWar.Window.TProcessorWindowSoulExchange;
   import Processors.Game.Lobby.CrossServerWar.Window.TProcessorWindowTokenExchange;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowCrossSeverBuyGoods;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CROSSSERVERWAR;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.Sprite;
   import flash.utils.ByteArray;
   
   public class TProcessorCrossServerWarWindows extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_HEIGHT:uint = 146;
      
      protected static const SIZE_WIDTH:uint = 195;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected static const Window_Width:int = 409;
      
      protected static const Window_Height:int = 379;
      
      protected var FProcessorWindowSoulExchange:TProcessorWindowSoulExchange;
      
      protected var FProcessorWindowChallengeRankings:TProcessorWindowChallengeRankings;
      
      protected var FProcessorWindowCheers:TProcessorWindowCheers;
      
      protected var FProcessorWindowExplanation:TProcessorWindowExplanation;
      
      protected var FProcessorWindowTokenExchange:TProcessorWindowTokenExchange;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FUIWindowBuyGoods:TUIWindowCrossSeverBuyGoods;
      
      protected var FWindowsVec:Vector.<Object>;
      
      protected var FUnstreamizerInventorySamples:TUnstreamizerInventorySamples;
      
      protected var FOrangeInventorySamples:TOrangeInventorySamples;
      
      protected var FTokenInventorySamples:TTokenInventorySamples;
      
      protected var FInventorySample:TInventoryReference;
      
      protected var FIntegralRankings:TIntegralRankings;
      
      protected var FSingleRank:uint;
      
      protected var FEliteRecord:TEliteRecord;
      
      protected var FIsInit:Boolean;
      
      protected var FContext:Object;
      
      protected var FGSPVP_DailyAward:TGSPVP_DailyAward;
      
      protected var FPopWindow:TUIWindowConfirmation;
      
      protected var FOnEliteApply:Function;
      
      protected var FOnToastClick:Function;
      
      protected var FOnRecruitCLick:Function;
      
      protected var FOnItemExchangeClick:Function;
      
      protected var FOnTokenExchangeClick:Function;
      
      protected var FOnRankingsReq:Function;
      
      protected var FOnToastReq:Function;
      
      protected var FOnEliteRecordReq:Function;
      
      public function TProcessorCrossServerWarWindows(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FWindowsVec = new Vector.<Object>();
         this.FProcessorWindowExplanation = new TProcessorWindowExplanation(this);
         this.FProcessorWindowExplanation.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowExplanation.OnOpenSoulExchange = this.ProcessorOnOpenSoulExchange;
         this.FProcessorWindowExplanation.OnOpenToast = this.ProcessorOnOpenToast;
         this.FProcessorWindowExplanation.OnOpenRankings = this.ProcessorOnOpenScoreRanking;
         this.FProcessorWindowExplanation.OnOpenTokenExchange = this.ProcessorOnOpenTokenExchange;
         this.FProcessorWindowExplanation.OnEliteApply = this.ProcessorOnEliteApply;
         this.FProcessorWindowExplanation.HelpOnOut = this.UIHelpHintOnOut;
         this.FProcessorWindowExplanation.HelpOnOver = this.UIHelpHintOnOver;
         this.FProcessorWindowExplanation.Visible = false;
         this.FProcessorWindowChallengeRankings = new TProcessorWindowChallengeRankings(this);
         this.FProcessorWindowChallengeRankings.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowCheers = new TProcessorWindowCheers(this);
         this.FProcessorWindowCheers.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowCheers.OnToastClick = this.ProcessorOnToastClick;
         this.FProcessorWindowSoulExchange = new TProcessorWindowSoulExchange(this);
         this.FProcessorWindowSoulExchange.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowSoulExchange.SlotOnOver = UIComponentsHintOnOver;
         this.FProcessorWindowSoulExchange.SlotOnOut = UIComponentsHintOnOut;
         this.FProcessorWindowSoulExchange.OnRecruitCLick = this.ProcessorOnLookHeroInfo;
         this.FProcessorWindowSoulExchange.OnItemExchangeClick = this.ProcessorOnItemExchangeClick;
         this.FProcessorWindowSoulExchange.HelpOnOut = this.UIHelpHintOnOut;
         this.FProcessorWindowSoulExchange.HelpOnOver = this.UIHelpHintOnOver;
         this.FProcessorWindowTokenExchange = new TProcessorWindowTokenExchange(this);
         this.FProcessorWindowTokenExchange.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowTokenExchange.SlotOnOver = UIComponentsHintOnOver;
         this.FProcessorWindowTokenExchange.SlotOnOut = UIComponentsHintOnOut;
         this.FProcessorWindowTokenExchange.OnTokenExchangeClick = this.ProcessorOnTokenExchangeClick;
         this.FProcessorWindowTokenExchange.HelpOnOut = this.UIHelpHintOnOut;
         this.FProcessorWindowTokenExchange.HelpOnOver = this.UIHelpHintOnOver;
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.OnRecruitCLick = this.ProcessorOnRecruitCLick;
         this.FProcessorWindowRecruit.HintOnOver = this.UIHintOnOver;
         this.FProcessorWindowRecruit.HintOnOut = this.UIHintOnOut;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - Window_Width) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - Window_Height) / 2;
         this.FWindowsVec.push(this.FProcessorWindowExplanation);
         this.FWindowsVec.push(this.FProcessorWindowChallengeRankings);
         this.FWindowsVec.push(this.FProcessorWindowCheers);
         this.FWindowsVec.push(this.FProcessorWindowSoulExchange);
         this.FWindowsVec.push(this.FProcessorWindowTokenExchange);
         this.FUnstreamizerInventorySamples = new TUnstreamizerInventorySamples();
         this.FOrangeInventorySamples = new TOrangeInventorySamples();
         this.FTokenInventorySamples = new TTokenInventorySamples();
         FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_CrossServerWar);
         FOverlayerEquipment.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_CrossServerWar);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_CrossServerWar);
         FOverlayerTreasure.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_CrossServerWar);
         FOverlayerAccessory.Visible = false;
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.Visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         this.FEliteRecord = SLogicsCore.EliteRecord;
         SetUIModuleID(CONST_MODULES.MODULE_CrossServerWar);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_CROSSSERVERWAR.RESOURCESID_Swf_CrossServerWar);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FUIWindowBuyGoods = new TUIWindowCrossSeverBuyGoods(this,CONST_MODULES.MODULE_CrossServerWar);
         this.FUIWindowBuyGoods.Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_BuyGoods") as Sprite;
         this.FUIWindowBuyGoods.Scene.x = (CONST_COMMON.STAGE_Width - this.FUIWindowBuyGoods.Window_Width) / 2;
         this.FUIWindowBuyGoods.Scene.y = (CONST_COMMON.STAGE_Height - this.FUIWindowBuyGoods.Window_Height) / 2;
         this.FUIWindowBuyGoods.Init();
         this.FUIWindowBuyGoods.OnOK = this.WindowOnOk;
         this.FUIWindowBuyGoods.OnCancel = this.WindowOnCancel;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         this.FPopWindow = new TUIWindowConfirmation(this);
         this.FPopWindow.OnOK = this.PopWindowOnOk;
         this.FPopWindow.x = CONST_COMMON.STAGE_Width - this.FPopWindow.WindowWidth >> 1;
         this.FPopWindow.y = CONST_COMMON.STAGE_Height - this.FPopWindow.WindowHeight >> 1;
         TUtilityUIWindow.SetupWindowConfirmation(this.FPopWindow);
         this.FPopWindow.visible = false;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         if(Visible && this.FProcessorWindowRecruit.Visible)
         {
            this.FProcessorWindowRecruit.UpdataBitmap();
         }
         super.LogicsPerform();
      }
      
      protected function ProcessorOnClose(param1:Object) : void
      {
         if(param1 is TProcessorWindowExplanation || !this.FProcessorWindowExplanation.Visible)
         {
            ProcessorClose();
         }
         else
         {
            param1.Visible = false;
         }
      }
      
      protected function ProcessorOnOpenSoulExchange(param1:Object) : void
      {
         this.FProcessorWindowSoulExchange.Visible = true;
         this.FProcessorWindowSoulExchange.UpdateUI(this.FOrangeInventorySamples);
      }
      
      protected function ProcessorOnOpenTokenExchange(param1:Object) : void
      {
         this.FProcessorWindowTokenExchange.Visible = true;
         this.FProcessorWindowTokenExchange.UpdateUI(this.FTokenInventorySamples);
      }
      
      protected function ProcessorOnOpenToast(param1:Object) : void
      {
         this.FProcessorWindowCheers.Visible = true;
         this.FProcessorWindowCheers.UpdateUI();
         if(this.FOnToastReq != null)
         {
            this.FOnToastReq(this);
         }
      }
      
      protected function ProcessorOnOpenScoreRanking(param1:Object) : void
      {
         if(this.FOnRankingsReq != null)
         {
            this.FOnRankingsReq(this);
         }
      }
      
      protected function ProcessorOnEliteApply(param1:Object) : void
      {
         if(this.FOnEliteApply != null)
         {
            this.FOnEliteApply(this);
         }
      }
      
      protected function ProcessorOnToastClick(param1:Object, param2:Object) : void
      {
         var _loc3_:String = null;
         this.FGSPVP_DailyAward = param2 as TGSPVP_DailyAward;
         if(this.FGSPVP_DailyAward.CostType > 1)
         {
            _loc3_ = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_CrossServerWar_Challenge).DescribeString,this.FGSPVP_DailyAward.Cost);
            this.FPopWindow.Text = _loc3_;
            this.FPopWindow.visible = true;
         }
         else
         {
            this.PopWindowOnOk(null);
         }
      }
      
      public function PopWindowOnOk(param1:Object) : void
      {
         if(this.FOnToastClick != null)
         {
            this.FOnToastClick(this,this.FGSPVP_DailyAward);
         }
      }
      
      protected function ProcessorOnLookHeroInfo(param1:Object, param2:Object) : void
      {
         var _loc3_:TTavernWarrior = null;
         var _loc4_:TTavernWarrior = null;
         var _loc5_:TOrangeInventorySample = null;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:TBins = null;
         var _loc9_:TBaseHero = null;
         var _loc10_:Boolean = false;
         _loc5_ = param2 as TOrangeInventorySample;
         _loc8_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Tavern_Warrior) as TBins;
         _loc7_ = uint(_loc8_.Count);
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc4_ = _loc8_.GetDatebaseByIndex(_loc6_) as TTavernWarrior;
            if(_loc4_.AwardId == _loc5_.TemplateID)
            {
               _loc3_ = _loc4_;
               break;
            }
            _loc6_++;
         }
         _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc5_.TemplateID) as TBaseHero;
         _loc10_ = this.FEliteRecord.OrangeSoulCount >= _loc5_.ExchangeCount && SLogicsCore.Character.GetMainLevel() >= _loc9_.NeedLevel;
         this.FProcessorWindowRecruit.SetRecruitData(_loc3_,_loc10_,3);
         this.FProcessorWindowRecruit.Visible = true;
         this.FContext = param2;
      }
      
      protected function ProcessorOnItemExchangeClick(param1:Object, param2:Object) : void
      {
         this.FUIWindowBuyGoods.Visible = true;
         this.FInventorySample = param2 as TOrangeInventorySample;
         this.FUIWindowBuyGoods.Context = param2;
         this.FUIWindowBuyGoods.Update();
      }
      
      protected function ProcessorOnTokenExchangeClick(param1:Object, param2:Object) : void
      {
         this.FUIWindowBuyGoods.Visible = true;
         this.FInventorySample = param2 as TTokenInventorySample;
         this.FUIWindowBuyGoods.Context = param2;
         this.FUIWindowBuyGoods.Update();
      }
      
      protected function ProcessorOnRecruitCLick(param1:Object, param2:Object) : void
      {
         if(this.FOnRecruitCLick != null)
         {
            this.FOnRecruitCLick(this,this.FContext);
         }
      }
      
      protected function UIHintOnOver(param1:Object, param2:THint) : void
      {
         FOverlayerHint.Context = param2;
         FOverlayerHint.Render(FUICore.MouseCoordinate);
         FOverlayerHint.Show();
      }
      
      protected function UIHintOnOut(param1:Object, param2:Object = null) : void
      {
         FOverlayerHint.Hide();
      }
      
      protected function UIHelpHintOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:THint = null;
         _loc3_ = param2 as THint;
         FOverlayerHelpTips.Context = _loc3_;
         FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         FOverlayerHelpTips.Show();
      }
      
      protected function UIHelpHintOnOut(param1:Object) : void
      {
         FOverlayerHelpTips.Hide();
      }
      
      protected function WindowOnOk(param1:Object) : void
      {
         this.FUIWindowBuyGoods.Reset();
         if(this.FInventorySample is TOrangeInventorySample)
         {
            this.FOnItemExchangeClick(this,this.FInventorySample,this.FUIWindowBuyGoods.Value);
         }
         else if(this.FInventorySample is TTokenInventorySample)
         {
            this.FOnTokenExchangeClick(this,this.FInventorySample,this.FUIWindowBuyGoods.Value);
         }
      }
      
      protected function WindowOnCancel(param1:Object) : void
      {
         this.FUIWindowBuyGoods.Reset();
      }
      
      public function get OnEliteApply() : Function
      {
         return this.FOnEliteApply;
      }
      
      public function set OnEliteApply(param1:Function) : void
      {
         this.FOnEliteApply = param1;
      }
      
      public function get OnToastClick() : Function
      {
         return this.FOnToastClick;
      }
      
      public function set OnToastClick(param1:Function) : void
      {
         this.FOnToastClick = param1;
      }
      
      public function get OnRecruitCLick() : Function
      {
         return this.FOnRecruitCLick;
      }
      
      public function set OnRecruitCLick(param1:Function) : void
      {
         this.FOnRecruitCLick = param1;
      }
      
      public function get OnItemExchangeClick() : Function
      {
         return this.FOnItemExchangeClick;
      }
      
      public function set OnItemExchangeClick(param1:Function) : void
      {
         this.FOnItemExchangeClick = param1;
      }
      
      public function get OnTokenExchangeClick() : Function
      {
         return this.FOnTokenExchangeClick;
      }
      
      public function set OnTokenExchangeClick(param1:Function) : void
      {
         this.FOnTokenExchangeClick = param1;
      }
      
      public function get OnRankingsReq() : Function
      {
         return this.FOnRankingsReq;
      }
      
      public function set OnRankingsReq(param1:Function) : void
      {
         this.FOnRankingsReq = param1;
      }
      
      public function get OnToastReq() : Function
      {
         return this.FOnToastReq;
      }
      
      public function set OnToastReq(param1:Function) : void
      {
         this.FOnToastReq = param1;
      }
      
      public function get OnEliteRecordReq() : Function
      {
         return this.FOnEliteRecordReq;
      }
      
      public function set OnEliteRecordReq(param1:Function) : void
      {
         this.FOnEliteRecordReq = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         if(!FIsResourcesLoadCompleted)
         {
            super.Mount(param1);
            this.FProcessorWindowExplanation.Load();
            this.FProcessorWindowCheers.Load();
            this.FProcessorWindowSoulExchange.Load();
            this.FProcessorWindowChallengeRankings.Load();
            this.FProcessorWindowTokenExchange.Load();
            this.FProcessorWindowRecruit.Load();
            if(this.FOnEliteRecordReq != null)
            {
               this.FOnEliteRecordReq(this);
            }
            return;
         }
         this.FProcessorWindowExplanation.Update();
         if(this.FIntegralRankings != null)
         {
            this.FProcessorWindowChallengeRankings.UpdateRankings(this.FIntegralRankings,this.FSingleRank);
         }
         if(this.FOrangeInventorySamples != null)
         {
            this.FProcessorWindowSoulExchange.UpdateUI(this.FOrangeInventorySamples);
         }
         if(this.FTokenInventorySamples != null)
         {
            this.FProcessorWindowTokenExchange.UpdateUI(this.FTokenInventorySamples);
         }
         this.FProcessorWindowCheers.UpdateUI();
      }
      
      public function InitCrossServerMallInfo() : void
      {
         this.FUnstreamizerInventorySamples.UnstreamizeOrangeInventorySamplesByDatabase(null,this.FOrangeInventorySamples,null);
         this.FUnstreamizerInventorySamples.UnstreamizeTokenInventorySamplesByDatabase(null,this.FTokenInventorySamples,null);
      }
      
      public function UpdateRankings(param1:TIntegralRankings, param2:uint) : void
      {
         this.FIntegralRankings = param1;
         this.FSingleRank = param2;
      }
      
      public function UpdateExplanationUI() : void
      {
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowExplanation.Update();
         }
      }
      
      public function UpdateToastRecord(param1:Object) : void
      {
         this.FProcessorWindowCheers.UpdateToastRecord(param1);
      }
      
      public function ShowWindow(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         if(this.FProcessorWindowExplanation.Visible)
         {
            _loc4_ = 1;
         }
         else
         {
            _loc4_ = 0;
         }
         _loc3_ = this.FWindowsVec.length;
         _loc2_ = int(_loc4_);
         while(_loc2_ < _loc3_)
         {
            if(param1 == _loc2_)
            {
               this.FWindowsVec[_loc2_].visible = true;
            }
            else
            {
               this.FWindowsVec[_loc2_].visible = false;
            }
            _loc2_++;
         }
      }
   }
}

