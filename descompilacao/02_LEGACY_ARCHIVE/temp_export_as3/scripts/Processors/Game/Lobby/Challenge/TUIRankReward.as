package Processors.Game.Lobby.Challenge
{
   import Components.Pages.TUIPage;
   import Foundation.Common.THint;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.Challenge.TChallenge;
   import Logics.DatebaseVO.VO.Json.TTaskReward;
   import Logics.DatebaseVO.VO.TChallengeWeekReward;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_CHALLENGE;
   import Resources.Strings.STRING_PALACE;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIRankReward extends TUIBaseWindow
   {
      
      protected static const REWARD_COUNT:int = 3;
      
      protected static const REWARD_ITEM_COUNT:int = 4;
      
      protected var FChallenge:TChallenge;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FMyReward:TUIShowItem;
      
      protected var FRewardList:Vector.<TUIShowItem>;
      
      protected var FHelpTips:THint;
      
      protected var FChallengeWeekReward:TBins;
      
      protected var FArticleBins:TBins;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUIRankReward(param1:TUIComponent)
      {
         super(param1);
         this.FChallenge = SLogicsCore.Challenge;
         this.FUIPage = new TUIPage(this);
         this.FHelpTips = new THint();
         this.FRewardList = new Vector.<TUIShowItem>(REWARD_COUNT);
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIShowItem = null;
         super.Resources_UIDispatch(param1);
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         FMC_Scene = param1;
         addChild(FMC_Scene);
         FMC_Scene.x = (FUICore.StageWidth - FMC_Scene.width) / 2;
         FMC_Scene.y = (FUICore.StageHeight - FMC_Scene.height) / 2;
         this.FMyReward = new TUIShowItem(this,REWARD_ITEM_COUNT);
         this.FMyReward.Perform_UIDispatch(FMC_Scene.MC_MyRank);
         this.FMyReward.OnOverlay = this.ProcessorOnItemOver;
         this.FMyReward.OnOut = this.ProcessorOnItemOut;
         _loc2_ = 0;
         while(_loc2_ < REWARD_COUNT)
         {
            _loc5_ = new TUIShowItem(this,REWARD_ITEM_COUNT);
            _loc5_.Perform_UIDispatch(FMC_Scene["MC_Rank" + _loc2_]);
            _loc5_.OnOverlay = this.ProcessorOnItemOver;
            _loc5_.OnOut = this.ProcessorOnItemOut;
            this.FRewardList[_loc2_] = _loc5_;
            _loc2_++;
         }
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_ChangePage.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_ChangePage.MC_PageRight;
         this.FUIPage.LabelPage = FMC_Scene.MC_ChangePage.TF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = REWARD_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         FMC_Scene.BTN_Close.addEventListener(MouseEvent.CLICK,this.OnCloseMain);
         FMC_Scene.BTN_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver);
         FMC_Scene.BTN_Help.addEventListener(MouseEvent.ROLL_OUT,this.ButtonHelpOnOut);
         this.FChallengeWeekReward = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ChallengeWeekReward);
         this.FArticleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:TChallengeWeekReward = null;
         var _loc7_:String = null;
         var _loc8_:Vector.<uint> = null;
         var _loc9_:Vector.<uint> = null;
         var _loc10_:uint = 0;
         var _loc11_:TInventories = null;
         var _loc12_:TInventory = null;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:TTaskReward = null;
         _loc8_ = new Vector.<uint>();
         _loc9_ = new Vector.<uint>();
         FMC_Scene.TF_Hurt.text = this.FChallenge.CurHurt.toString();
         if(this.FChallenge.CurRank <= 0)
         {
            FMC_Scene.TF_Rank.text = STRING_BASEACTIVITY.FORMAT_NEVER_IN_RANK;
            _loc11_ = new TInventories();
            this.FMyReward.UpdateUI(_loc11_);
         }
         else
         {
            FMC_Scene.TF_Rank.text = this.FChallenge.CurRank.toString();
            _loc1_ = this.FChallenge.CurRankIndex();
            _loc6_ = this.FChallengeWeekReward.GetDatebaseByIndex(_loc1_) as TChallengeWeekReward;
            FMC_Scene.MC_MyRank.MC_Back.gotoAndStop(_loc6_.Resource);
            _loc8_.length = 0;
            _loc9_.length = 0;
            _loc11_ = new TInventories();
            _loc3_ = int(_loc6_.Rewards.length);
            _loc1_ = 0;
            while(_loc1_ < _loc3_)
            {
               _loc16_ = _loc6_.Rewards[_loc1_];
               _loc13_ = _loc16_.Type;
               _loc14_ = _loc16_.Code;
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc13_,_loc14_,this.FArticleBins);
               _loc8_.push(_loc10_);
               _loc9_.push(_loc16_.Amount);
               _loc1_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc8_);
            _loc1_ = 0;
            while(_loc1_ < _loc3_)
            {
               _loc12_ = _loc11_.GetInventoryByIndex(_loc1_);
               _loc12_.Quantity = _loc9_[_loc1_];
               _loc1_++;
            }
            this.FMyReward.UpdateUI(_loc11_);
         }
         this.FUIPage.TotalQuantity = this.FChallengeWeekReward.Count;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < REWARD_COUNT)
         {
            _loc5_ = FMC_Scene["MC_Rank" + _loc1_];
            _loc4_ = _loc1_ + this.FCurPage * REWARD_COUNT;
            if(_loc4_ < this.FChallengeWeekReward.Count)
            {
               _loc5_.visible = true;
               _loc6_ = this.FChallengeWeekReward.GetDatebaseByIndex(_loc4_) as TChallengeWeekReward;
               _loc7_ = new ConsumeFrameCopy(STRING_CHALLENGE.STRING_002).DescribeString;
               if(_loc6_.Rank[0] != _loc6_.Rank[1])
               {
                  FMC_Scene["TF_No" + _loc1_].text = TUtilityString.Format(_loc7_,_loc6_.Rank[0],_loc6_.Rank[1]);
               }
               else
               {
                  FMC_Scene["TF_No" + _loc1_].text = TUtilityString.Format(STRING_PALACE.FORMAT_Ranking,_loc6_.Rank[0]);
               }
               _loc5_.MC_Back.gotoAndStop(_loc6_.Resource);
               _loc8_.length = 0;
               _loc9_.length = 0;
               _loc11_ = new TInventories();
               _loc3_ = int(_loc6_.Rewards.length);
               _loc2_ = 0;
               while(_loc2_ < _loc3_)
               {
                  _loc16_ = _loc6_.Rewards[_loc2_];
                  _loc13_ = _loc16_.Type;
                  _loc14_ = _loc16_.Code;
                  _loc10_ = CONST_COMMON.GetItemIDByType(_loc13_,_loc14_,this.FArticleBins);
                  _loc8_.push(_loc10_);
                  _loc9_.push(_loc16_.Amount);
                  _loc2_++;
               }
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc8_);
               _loc2_ = 0;
               while(_loc2_ < _loc3_)
               {
                  _loc12_ = _loc11_.GetInventoryByIndex(_loc2_);
                  _loc12_.Quantity = _loc9_[_loc2_];
                  _loc2_++;
               }
               this.FRewardList[_loc1_].UpdateUI(_loc11_);
            }
            else
            {
               _loc5_.visible = false;
               FMC_Scene["TF_No" + _loc1_].text = "";
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateBox();
      }
      
      protected function OnCloseMain(param1:MouseEvent) : void
      {
         if(FOnCloseWindow != null)
         {
            FOnCloseWindow(this);
         }
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(OnHelpOver != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_70170103) as TSystemLanguage;
            this.FHelpTips.Content = _loc2_.Desc;
            OnHelpOver(this,this.FHelpTips);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(OnHelpOut != null)
         {
            OnHelpOut(this);
         }
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
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FRewardList.length)
            {
               this.FRewardList[_loc1_].LogicsPerform();
               _loc1_++;
            }
            if(this.FMyReward)
            {
               this.FMyReward.LogicsPerform();
            }
         }
      }
      
      public function UpdateWindow() : void
      {
         this.UpdateBox();
      }
      
      override public function Unmount() : void
      {
      }
   }
}

