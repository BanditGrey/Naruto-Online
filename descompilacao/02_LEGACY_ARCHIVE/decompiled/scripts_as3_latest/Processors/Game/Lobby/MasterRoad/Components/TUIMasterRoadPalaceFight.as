package Processors.Game.Lobby.MasterRoad.Components
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TMasterRoadBattle;
   import Logics.DatebaseVO.VO.TMasterRoadVenue;
   import Logics.Exercise.TBaseActivity;
   import Logics.MasterRoad.TMasterRoad;
   import Logics.SLogicsCore;
   import Processors.Game.Battle.Character.TActive;
   import Processors.Game.Battle.Character.TPoolRole;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.MasterRoad.TProcessorMasterRoad;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_MASTERROAD;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.data.Json;
   
   public class TUIMasterRoadPalaceFight extends TUIBaseWindow
   {
      
      public static const TAB_COUNT:int = 3;
      
      public static const TAB_COUNT_1:int = 10;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 2;
      
      public static const FilterGlowStrength:int = 10;
      
      protected var FMasterRoad:TMasterRoad;
      
      protected var FPalaceIndex:int;
      
      protected var FUITab:TUITab;
      
      protected var FChangeTabIndex:int;
      
      protected var FUITab1:TUITab;
      
      protected var FChangeTabIndex1:int;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FBattleList:Vector.<TMasterRoadBattle>;
      
      protected var FBattle:TMasterRoadBattle;
      
      protected var FActive:TActive;
      
      protected var FGlowsFilter:TEffectBaseGlowTwo;
      
      public function TUIMasterRoadPalaceFight(param1:TUIComponent)
      {
         super(param1);
         this.FMasterRoad = SLogicsCore.MasterRoad;
         this.FUITab = new TUITab(this);
         this.FUITab1 = new TUITab(this);
         this.FBattleList = new Vector.<TMasterRoadBattle>();
         this.FUIPage = new TUIPage(this);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         super.Resources_UIDispatch(param1);
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
            this.FUITab1.SetTabByIndex(FMC_Scene["BTN_Enemy" + _loc2_],_loc2_);
            _loc2_++;
         }
         this.FUITab1.OnSwitch = this.TabOnSwitch1;
         this.FUITab1.Init();
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_Page.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_Page.MC_PageRight;
         this.FUIPage.LabelPage = FMC_Scene.MC_Page.TF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = TAB_COUNT_1;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         FMC_Scene.MC_Box.MC_Pic.buttonMode = true;
         FMC_Scene.MC_Box.MC_Pic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
         FMC_Scene.MC_Box.MC_Pic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         TGameUtil.setButtonMode(FMC_Scene.MC_Box.BTN_Get,true);
         FMC_Scene.MC_Box.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBoxUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Fight,true);
         FMC_Scene.BTN_Fight.addEventListener(MouseEvent.CLICK,this.ProcessorOnFightUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Add,true);
         FMC_Scene.BTN_Add.addEventListener(MouseEvent.CLICK,this.ProcessorOnAddUp);
         this.FGlowsFilter = new TEffectBaseGlowTwo();
         this.FGlowsFilter.SetParameters(FMC_Scene.MC_Box.BTN_Get,FilterColor,FilterGlowWidth,FilterGlowStrength);
      }
      
      protected function UpdateTab() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TMasterRoadVenue = null;
         var _loc6_:String = null;
         _loc5_ = this.FMasterRoad.VenuesData[this.FPalaceIndex];
         _loc3_ = Json.decode(_loc5_.battleFunction);
         this.FBattleList.length = 0;
         _loc1_ = 0;
         while(_loc1_ < _loc5_.BattleList.length)
         {
            if(_loc5_.BattleList[_loc1_].theFunction == this.FChangeTabIndex + 1)
            {
               this.FBattleList.push(_loc5_.BattleList[_loc1_]);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Tab" + _loc1_];
            if(_loc1_ < _loc5_.TotalBattleType)
            {
               _loc4_.visible = true;
               _loc4_.TF_Caption.text = _loc3_[_loc1_][1];
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc1_++;
         }
         this.FUIPage.TotalQuantity = this.FBattleList.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT_1)
         {
            _loc4_ = FMC_Scene["BTN_Enemy" + _loc1_];
            _loc2_ = _loc1_ + this.FCurPage * TAB_COUNT_1;
            if(_loc2_ < this.FBattleList.length)
            {
               _loc4_.visible = true;
               _loc4_.TF_Caption.text = this.FBattleList[_loc2_].name;
               if(this.FBattleList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc4_.MC_Click.visible = true;
               }
               else
               {
                  _loc4_.MC_Click.visible = false;
               }
               if(this.FBattleList[_loc2_].BattleStatus == TBaseActivity.STATUS_GETED)
               {
                  _loc4_.MC_Complete.visible = true;
               }
               else
               {
                  _loc4_.MC_Complete.visible = false;
               }
               if(this.FBattleList[_loc2_].BattleStatus == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc4_.filters = [TGameUtil.GaryColorFilters];
               }
               else
               {
                  _loc4_.filters = [];
               }
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc1_++;
         }
         this.FBattle = this.FBattleList[this.FChangeTabIndex1 + this.FCurPage * TAB_COUNT_1];
         FMC_Scene.TF_Title.text = this.FBattle.title;
         FMC_Scene.TF_Tip.text = this.FBattle.description;
         FMC_Scene.TF_Name.text = this.FBattle.stageName;
         FMC_Scene.TF_Score.text = TUtilityString.Format(new ConsumeFrameCopy(STRING_MASTERROAD.STRING_003).DescribeString,this.FBattle.achievementReward);
         FMC_Scene.TF_Count.text = this.FBattle.LimitCount.toString();
         _loc6_ = "";
         _loc3_ = Json.decode(this.FBattle.battleCondition);
         _loc1_ = 0;
         while(_loc1_ < _loc3_.length)
         {
            _loc6_ = _loc3_[_loc1_] + "\n";
            _loc1_++;
         }
         FMC_Scene.TF_Command.text = _loc6_;
         if(this.FBattle.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.MC_Box.MC_Got.visible = false;
            FMC_Scene.MC_Box.BTN_Get.visible = false;
            FMC_Scene.BTN_Fight.visible = true;
            FMC_Scene.MC_Complete.visible = false;
            this.FGlowsFilter.Stop();
         }
         else if(this.FBattle.Status == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.MC_Box.MC_Got.visible = false;
            FMC_Scene.MC_Box.BTN_Get.visible = true;
            FMC_Scene.BTN_Fight.visible = false;
            FMC_Scene.MC_Complete.visible = true;
            this.FGlowsFilter.IsRunOver = false;
         }
         else
         {
            FMC_Scene.MC_Box.MC_Got.visible = true;
            FMC_Scene.MC_Box.BTN_Get.visible = false;
            FMC_Scene.BTN_Fight.visible = false;
            FMC_Scene.MC_Complete.visible = true;
            this.FGlowsFilter.Stop();
         }
         if(this.FBattle.LimitCount > 0)
         {
            FMC_Scene.MC_NoCount.visible = false;
            if(this.FBattle.BattleStatus == TBaseActivity.STATUS_CANNOTGET)
            {
               TGameUtil.setButtonMode(FMC_Scene.BTN_Fight,false);
            }
            else
            {
               TGameUtil.setButtonMode(FMC_Scene.BTN_Fight,true);
            }
            TGameUtil.setButtonMode(FMC_Scene.BTN_Add,false);
         }
         else
         {
            FMC_Scene.MC_NoCount.visible = true;
            FMC_Scene.BTN_Fight.visible = false;
            if(this.FBattle.Price == TBaseActivity.STATUS_GETED)
            {
               TGameUtil.setButtonMode(FMC_Scene.BTN_Add,false);
            }
            else
            {
               TGameUtil.setButtonMode(FMC_Scene.BTN_Add,true);
            }
         }
         if(!this.FActive)
         {
            this.FActive = TPoolRole.GetActive(this,this.FBattle.model,CONST_MODULES.MODULE_MasterRoad,true,false);
         }
         else
         {
            this.FActive.parent.removeChild(this.FActive);
            this.FActive.ResetActive(this,this.FBattle.model,CONST_MODULES.MODULE_MasterRoad,true,false);
         }
         FMC_Scene.MC_Role.addChild(this.FActive);
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FChangeTabIndex = param1 as int;
         this.FCurPage = 0;
         this.FUIPage.Reset();
         this.FChangeTabIndex1 = 0;
         this.FUITab1.Reset();
         this.UpdateTab();
      }
      
      protected function TabOnSwitch1(param1:Object) : void
      {
         this.FChangeTabIndex1 = param1 as int;
         this.UpdateTab();
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.FChangeTabIndex1 = 0;
         this.UpdateTab();
      }
      
      protected function ProcessorOnFightUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null && this.FBattle.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            FOnGetBox(TProcessorMasterRoad.REQ_TYPE_FIGHT,this.FBattle.Identifier);
         }
      }
      
      protected function ProcessorOnAddUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnBuyBox != null)
         {
            FOnBuyBox(TProcessorMasterRoad.REQ_TYPE_BUY_FIGHT_COUNT,this.FBattle.Price,this.FBattle.Identifier,TBaseActivity.SWEET_TYPE_GOLD_GIFT);
         }
      }
      
      override protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null && this.FBattle.Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(TProcessorMasterRoad.REQ_TYPE_GET_FIGHT_AWARD,this.FBattle.Identifier);
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         if(FOnNewBoxOver != null && Boolean(this.FBattle))
         {
            FOnNewBoxOver(this.FBattle.AwardItems);
         }
      }
      
      protected function OnCloseMain(param1:MouseEvent) : void
      {
         if(FOnCloseWindow != null)
         {
            FOnCloseWindow(this);
         }
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
            if(this.FActive)
            {
               this.FActive.UpdateActive();
            }
            if(this.FGlowsFilter == null)
            {
               return;
            }
            if(!this.FGlowsFilter.IsRunOver)
            {
               this.FGlowsFilter.Run();
            }
         }
      }
      
      public function UpdateWindow(param1:int) : void
      {
         this.FPalaceIndex = param1;
         this.UpdateTab();
      }
      
      override public function Unmount() : void
      {
         this.FChangeTabIndex = 0;
         this.FChangeTabIndex1 = 0;
         this.FCurPage = 0;
         this.FUITab.Reset();
         this.FUIPage.Reset();
         this.FUITab1.Reset();
      }
   }
}

