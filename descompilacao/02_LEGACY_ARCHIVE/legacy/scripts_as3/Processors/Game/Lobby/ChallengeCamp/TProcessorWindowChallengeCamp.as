package Processors.Game.Lobby.ChallengeCamp
{
   import Components.Standard.TUITab;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Common.THint;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.ChallengeCamp.TChallengeCamp;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.DatebaseVO.VO.TWeekBoss;
   import Logics.Exercise.TBaseActivity;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Components.TUIHero;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowChallengeCamp extends TProcessorLobbyWindow
   {
      
      public static const TAB_COUNT:int = 10;
      
      protected var FMainPanel:MovieClip;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FUIModel:TUIHero;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FAddCountCost:Vector.<uint>;
      
      protected var FBuyCnt:int;
      
      protected var FUITab:TUITab;
      
      protected var FChangeTabIndex:int;
      
      protected var FCurrBattle:TWeekBoss;
      
      protected var FBattleList:Vector.<TWeekBoss>;
      
      protected var FChallengeCamp:TChallengeCamp;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FHint:THint;
      
      protected var FArticleBins:TBins;
      
      public var OnStartFight:Function;
      
      public var OnGetReward:Function;
      
      public var OnBuyRequest:Function;
      
      public function TProcessorWindowChallengeCamp(param1:TUIComponent)
      {
         super(param1);
         this.FUITab = new TUITab(this);
         this.FBattleList = new Vector.<TWeekBoss>();
         this.FHint = new THint();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TConfigValue = null;
         this.FMainPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_WeekBoss") as MovieClip;
         addChild(this.FMainPanel);
         this.FMC_Scene = this.FMainPanel.MC_Main;
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            this.FUITab.SetTabByIndex(this.FMC_Scene["BTN_Enemy" + _loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FUIModel = new TUIHero(this);
         this.FMC_Scene.MC_Role.addChild(this.FUIModel);
         this.FUIModel.OnQuerySequenceContext = this.OnQuerySequenceContext;
         this.FUIModel.DefaultRole = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as Sprite;
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Get,true);
         this.FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBoxUp);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Fight,true);
         this.FMC_Scene.BTN_Fight.addEventListener(MouseEvent.CLICK,this.ProcessorOnFightUp);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Add,true);
         this.FMC_Scene.BTN_Add.addEventListener(MouseEvent.CLICK,this.ProcessorOnClickAddTimes);
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this);
         this.FUIWindowConfirmation.OnOK = this.ProcessorOnAddUp;
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FOverlayerHint = new TOverlayerHint(this);
         this.FOverlayerHint.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this.Parent);
         this.FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         this.FArticleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,99200003) as TConfigValue;
         this.FAddCountCost = _loc3_.Value as Vector.<uint>;
         this.FMainPanel.x = stage.stageWidth - this.FMainPanel.width >> 1;
         this.FMainPanel.y = stage.stageHeight - this.FMainPanel.height >> 1;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMainPanel.BTN_Close.addEventListener(MouseEvent.CLICK,this.OnCloseWindow);
         this.FMainPanel.btn_help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver);
         this.FMainPanel.btn_help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut);
         this.FMC_Scene.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxMove);
         this.FMC_Scene.MC_Box.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnBoxOut);
         this.FMC_Scene.MC_Reward.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxMove);
         this.FMC_Scene.MC_Reward.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnBoxOut);
         super.ResourcesPerform_UILocations();
      }
      
      public function UpdateUI(param1:TChallengeCamp) : void
      {
         this.FChallengeCamp = param1;
         this.FBattleList = param1.BattleList;
         this.UpdateTab();
         this.TabOnSwitch(this.FChangeTabIndex);
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FChangeTabIndex = param1 as int;
         this.UpdateDetailInfo();
      }
      
      protected function UpdateTab() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:MovieClip = null;
         var _loc5_:String = null;
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            _loc4_ = this.FMC_Scene["BTN_Enemy" + _loc1_];
            if(_loc1_ < this.FBattleList.length)
            {
               _loc4_.visible = true;
               _loc4_.TF_Caption.text = this.FBattleList[_loc1_].Name;
               if(this.FBattleList[_loc1_].Status == TBaseActivity.STATUS_CANGET)
               {
               }
               if(this.FBattleList[_loc1_].BattleStatus == TBaseActivity.STATUS_CANGET)
               {
                  _loc4_.MC_Complete.visible = true;
               }
               else
               {
                  _loc4_.MC_Complete.visible = false;
               }
               if(this.FBattleList[_loc1_].BattleStatus == -1)
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
      }
      
      protected function UpdateDetailInfo() : void
      {
         var _loc1_:TWeekBoss = null;
         this.FCurrBattle = _loc1_ = this.FBattleList[this.FChangeTabIndex];
         this.FMC_Scene.TF_Tip.text = _loc1_.Description;
         this.FMC_Scene.TF_Name.text = _loc1_.StageName;
         this.FMC_Scene.TF_Count.text = _loc1_.LimitCount.toString();
         this.FUIModel.Context = _loc1_.Model;
         if(_loc1_.BattleStatus == TBaseActivity.STATUS_CANGET)
         {
            if(_loc1_.Status == 1)
            {
               this.FMC_Scene.MC_Box.MC_Got.visible = true;
               this.FMC_Scene.BTN_Get.visible = false;
            }
            else
            {
               this.FMC_Scene.MC_Box.MC_Got.visible = false;
               this.FMC_Scene.BTN_Get.visible = true;
            }
            this.FMC_Scene.BTN_Fight.visible = false;
            this.FMC_Scene.MC_Complete.visible = true;
         }
         else
         {
            this.FMC_Scene.MC_Box.MC_Got.visible = false;
            this.FMC_Scene.BTN_Get.visible = false;
            this.FMC_Scene.BTN_Fight.visible = true;
            this.FMC_Scene.MC_Complete.visible = false;
         }
         this.FMC_Scene.MC_Reward.MC_Got.visible = _loc1_.SpecialStatus == TBaseActivity.STATUS_IS_GOT;
         if(_loc1_.LimitCount > 0)
         {
            this.FMC_Scene.MC_NoCount.visible = false;
            if(_loc1_.BattleStatus == -1)
            {
               TGameUtil.setButtonMode(this.FMC_Scene.BTN_Fight,false);
            }
            else
            {
               TGameUtil.setButtonMode(this.FMC_Scene.BTN_Fight,true);
            }
            TGameUtil.setButtonMode(this.FMC_Scene.BTN_Add,false);
         }
         else
         {
            this.FMC_Scene.MC_NoCount.visible = true;
            this.FMC_Scene.BTN_Fight.visible = false;
            if(_loc1_.BuyCount == TBaseActivity.STATUS_GETED)
            {
               TGameUtil.setButtonMode(this.FMC_Scene.BTN_Add,false);
            }
            else
            {
               TGameUtil.setButtonMode(this.FMC_Scene.BTN_Add,true);
            }
         }
      }
      
      protected function ProcessorOnClickAddTimes(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         this.FUIWindowConfirmation.Text = TUtilityString.Format(TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_ChallengeCamp),this.FAddCountCost[this.FCurrBattle.BuyCount]);
         this.FUIWindowConfirmation.Visible = true;
      }
      
      protected function ProcessorOnFightUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.OnStartFight != null)
         {
            this.OnStartFight(this.FCurrBattle.Identifier);
         }
      }
      
      protected function ProcessorOnAddUp(param1:Object) : void
      {
         if(this.OnBuyRequest != null)
         {
            this.OnBuyRequest(this.FCurrBattle.Identifier,1);
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.OnGetReward != null)
         {
            this.OnGetReward(this.FCurrBattle.Identifier);
         }
      }
      
      protected function ProcessorOnBoxMove(param1:MouseEvent) : void
      {
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         var _loc5_:TArticle = null;
         var _loc6_:Array = null;
         if(!this.FCurrBattle)
         {
            return;
         }
         var _loc4_:String = "";
         if(param1.currentTarget == this.FMC_Scene.MC_Box)
         {
            _loc6_ = this.FCurrBattle.AwardArr;
         }
         else
         {
            _loc6_ = this.FCurrBattle.SpecialawardArr;
         }
         for each(_loc2_ in _loc6_)
         {
            _loc5_ = this.FArticleBins.GetDatebaseByIdentifier(_loc2_.code) as TArticle;
            _loc4_ += _loc5_.Name + "*" + _loc2_.amount + "\n";
         }
         this.FHint.Caption = _loc4_;
         this.FOverlayerHint.Context = this.FHint;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Show();
      }
      
      protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         this.FOverlayerHint.Hide();
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:THint = new THint();
         _loc2_.Content = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.HELPTIPS_ChallengeCamp);
         this.FOverlayerHelpTips.Context = _loc2_;
         this.FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         this.FOverlayerHelpTips.Show();
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         this.FOverlayerHelpTips.Hide();
      }
      
      protected function OnCloseWindow(param1:MouseEvent) : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      protected function OnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:int = 0;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         var _loc8_:TBounds = null;
         var _loc9_:TCoordinate = null;
         var _loc10_:TRoleModel = null;
         _loc5_ = param2 as int;
         _loc8_ = new TBounds();
         _loc9_ = new TCoordinate();
         _loc6_ = SResourcesCore.TexturesModel;
         _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc5_) as TRoleModel;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc10_.Model);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIndex(0);
            param3.Value.Evaluate(_loc9_,_loc8_);
            this.FUIModel.X = _loc8_.X;
            this.FUIModel.Y = _loc8_.Y;
         }
         else
         {
            _loc6_.LoadSecondary(_loc10_.Model,CONST_MODULES.MODULE_Heros);
            this.FUIModel.X = 0;
            this.FUIModel.Y = 0;
         }
      }
      
      override protected function LogicsPerform() : void
      {
         if(this.FUIModel)
         {
            this.FUIModel.Update();
         }
         super.LogicsPerform();
      }
   }
}

