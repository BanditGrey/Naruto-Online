package Processors.Game.Lobby.Exercise.WishTree
{
   import Components.Pages.TUIPage;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.WishTree.TWishTree;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerWishTree;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Streamization.Title.TUnstreamizerTitle;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Rendering.Overlayers.Box.TOverlayerItemNoPrice;
   import Rendering.Overlayers.Title.TOverlayerTitle;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_SEVENTHEVENING;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TProcessorWishTree extends TProcessorBaseActivity
   {
      
      public static const RANK_COUNT:int = 11;
      
      public static const BOX_COUNT:int = 6;
      
      public static const REQ_BUY_WISH:int = 1;
      
      public static const REQ_BUY_WRONG:int = 2;
      
      public static const REQ_CANCEL:int = 3;
      
      public static const REQ_GET_REWARD:int = 4;
      
      protected var FWishTree:TWishTree;
      
      protected var FBeClicked:Boolean;
      
      protected var FUnstreamizerWishTree:TUnstreamizerWishTree;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FProcessorWishTreeRank:TProcessorWishTreeRank;
      
      protected var FUIWindowWishTreeBuyWrong:TUIWindowWishTreeBuyWrong;
      
      protected var FOverlayerItemAndPoint:TOverlayerItemNoPrice;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_ChangePage:MovieClip;
      
      protected var FUI_Left_Btn:MovieClip;
      
      protected var FUI_Right_Btn:MovieClip;
      
      protected var FTF_Page:TextField;
      
      protected var FRankList:Vector.<Sprite>;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FMC_Rank:MovieClip;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FCost:int;
      
      protected var FOverlayerTitle:TOverlayerTitle;
      
      protected var FAllTitles:TTitles;
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      protected var FWishEndTimeID:int;
      
      protected var FArticleBins:TBins;
      
      protected var FIsPlaying:Boolean;
      
      protected var FMovieIndex:int;
      
      protected var FTotalFrame:int;
      
      protected var CurFrame:int;
      
      public function TProcessorWishTree(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FWishTree = SLogicsCore.WishTree;
         this.FUnstreamizerWishTree = new TUnstreamizerWishTree();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FProcessorWishTreeRank = new TProcessorWishTreeRank(this.Parent);
         this.FUIWindowWishTreeBuyWrong = new TUIWindowWishTreeBuyWrong(this.Parent);
         this.FUIWindowWishTreeBuyWrong.OnOK = this.WindowConfirmationBuyWrongOnOK;
         this.FUIWindowWishTreeBuyWrong.OnCancel = this.WindowCofirmationBuyWrongOnCancel;
         this.FUIWindowWishTreeBuyWrong.Visible = false;
         this.FOverlayerTitle = new TOverlayerTitle(this.Parent);
         this.FOverlayerTitle.Visible = false;
         this.FAllTitles = new TTitles();
         this.FUnstreamizerTitle = new TUnstreamizerTitle();
         this.FOverlayerItemAndPoint = new TOverlayerItemNoPrice(this.Parent);
         this.FOverlayerItemAndPoint.Visible = false;
         this.FRankList = new Vector.<Sprite>(RANK_COUNT);
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         this.FProcessorWishTreeRank.OnCloseUp = this.ProcessorOnCloseWindow;
         this.FProcessorWishTreeRank.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWishTreeRank.OnOut = UIComponentsHintOnOut;
         this.FProcessorWishTreeRank.OnGetBox = this.ProcessorOnGetKillBoxUp;
         this.FProcessorWishTreeRank.TitleHintOnOver = this.ProcessorOnTitleOver;
         this.FProcessorWishTreeRank.TitleHintOnOut = this.ProcessorOnTitleOut;
         this.FProcessorWishTreeRank.Visible = false;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Box" + _loc1_];
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            this.FBoxList[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FUIPage = new TUIPage(this);
         this.FMC_Rank = FMC_Scene.MC_Rank;
         this.FMC_ChangePage = this.FMC_Rank.MC_ChangePage;
         this.FUI_Left_Btn = this.FMC_ChangePage["MC_PageLeft"];
         this.FUI_Right_Btn = this.FMC_ChangePage["MC_PageRight"];
         this.FTF_Page = this.FMC_ChangePage["TF_Page"];
         this.FUIPage.ButtonPrevious.Substrate = this.FUI_Left_Btn;
         this.FUIPage.ButtonNext.Substrate = this.FUI_Right_Btn;
         this.FUIPage.LabelPage = this.FTF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = RANK_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTitle);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerItemAndPoint);
         this.FArticleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         FMC_Scene.MC_Pet.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver);
         FMC_Scene.MC_Pet.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.ResourcesPerform_UILocations();
         FMC_Scene.BTN_GotoRank.addEventListener(MouseEvent.CLICK,this.ProcessorOnGotoRank);
         TGameUtil.setButtonMode(FMC_Scene.BTN_GotoRank,true);
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyUp);
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBtnOver);
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBtnOut);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,true);
         this.FUnstreamizerTitle.UnstreamizeTitleByDatabase(null,this.FAllTitles,null);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         super.LogicsPerform();
         if(FInitialized)
         {
            if(this.FIsPlaying)
            {
               _loc1_ = this.FBoxList[this.FMovieIndex].currentFrame;
               if(_loc1_ == this.FTotalFrame)
               {
                  this.FIsPlaying = false;
                  this.MovieEnd();
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateBox();
         this.UpdateRank();
         this.UpdateBtn();
         this.UpdateWindow();
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         if(this.FWishTree.CurRank == 0)
         {
            FMC_Scene.TF_CurRank.text = STRING_BASEACTIVITY.FORMAT_NEVER_IN_RANK;
         }
         else
         {
            FMC_Scene.TF_CurRank.text = this.FWishTree.CurRank.toString();
         }
         FMC_Scene.TF_Point.text = this.FWishTree.Point.toString();
         FMC_Scene.TF_FreeCount.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_FREE_COUNTS,this.FWishTree.FreeTimes);
         FTF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FWishTree.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FWishTree.EndTime) - 1) * 1000)));
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            this.FBoxList[_loc1_].MC_Icon.gotoAndStop(_loc1_ + 1);
            if(this.FWishTree.CurLevel - 1 == _loc1_)
            {
               this.FBoxList[_loc1_].filters = [TGameUtil.highLightFilters];
            }
            else
            {
               this.FBoxList[_loc1_].filters = [TGameUtil.GaryColorFilters];
            }
            _loc1_++;
         }
      }
      
      protected function UpdateRank() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TextField = null;
         var _loc5_:TextField = null;
         var _loc6_:TextField = null;
         var _loc7_:TConsumeRankInfo = null;
         this.FUIPage.TotalQuantity = this.FWishTree.RankList.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < RANK_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * RANK_COUNT;
            _loc3_ = this.FMC_Rank["MC_Rank" + _loc1_];
            _loc4_ = _loc3_.TF_Name;
            _loc5_ = _loc3_.TF_Count;
            _loc6_ = _loc3_.TF_ServerID;
            if(_loc2_ < this.FWishTree.RankList.length)
            {
               _loc7_ = this.FWishTree.RankList[_loc2_];
               if(this.FCurPage == 0)
               {
                  this.FMC_Rank["TF_FirstNum"].visible = true;
                  this.FMC_Rank["TF_SecondNum"].visible = true;
                  this.FMC_Rank["TF_ThirdNum"].visible = true;
               }
               else
               {
                  this.FMC_Rank["TF_FirstNum"].visible = false;
                  this.FMC_Rank["TF_SecondNum"].visible = false;
                  this.FMC_Rank["TF_ThirdNum"].visible = false;
               }
               _loc4_.visible = true;
               if(_loc2_ < 3)
               {
                  _loc4_.text = TUtilityString.Format(STRING_SEVENTHEVENING.FORMAT_RankNameNonePoint,_loc7_.UserName);
               }
               else
               {
                  _loc4_.text = TUtilityString.Format(STRING_SEVENTHEVENING.FORMAT_RankName,_loc2_ + 1,_loc7_.UserName);
               }
               _loc5_.visible = true;
               _loc6_.visible = true;
               _loc5_.text = _loc7_.Score.toString();
               _loc6_.text = _loc7_.ServerName;
            }
            else
            {
               _loc4_.visible = false;
               _loc5_.visible = false;
               _loc6_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBtn() : void
      {
         if(STimingCore.GetServerTick() > this.FWishTree.WishEndTime)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,false);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,true);
         }
      }
      
      protected function UpdateWindow() : void
      {
         if(this.FProcessorWishTreeRank.visible)
         {
            this.FProcessorWishTreeRank.UpdateUI();
         }
         if(this.FWishTree.IsFailed == TWishTree.IS_FAILED && STimingCore.GetServerTime() < this.FWishTree.WishEndTime)
         {
            this.FUIWindowWishTreeBuyWrong.Visible = true;
            this.FUIWindowWishTreeBuyWrong.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_COST_GOLD,this.FWishTree.RewardList[this.FWishTree.CurLevel - 1].Price);
         }
         else
         {
            this.FUIWindowWishTreeBuyWrong.Visible = false;
         }
      }
      
      protected function SetWishEndTime() : void
      {
         var _loc1_:Number = NaN;
         if(this.FWishEndTimeID != 0)
         {
            clearTimeout(this.FWishEndTimeID);
            this.FWishEndTimeID = 0;
         }
         _loc1_ = (this.FWishTree.WishEndTime - STimingCore.GetServerTick()) * 1000;
         if(_loc1_ < 0)
         {
            return;
         }
         if(_loc1_ > int.MAX_VALUE)
         {
            _loc1_ = int.MAX_VALUE;
         }
         this.FWishEndTimeID = setTimeout(this.UpdateBtn,_loc1_);
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateRank();
      }
      
      protected function ProcessorOnGotoRank(param1:MouseEvent) : void
      {
         if(this.FWishTree.KillBox[0] == null)
         {
            return;
         }
         this.FProcessorWishTreeRank.Visible = true;
         this.FProcessorWishTreeRank.UpdateUI();
         this.FUIWindowWishTreeBuyWrong.Visible = false;
      }
      
      override protected function ProcessorOnOpenDesc(param1:MouseEvent = null) : void
      {
         FProcessorWindowDesc.BaseActivity = this.FWishTree;
         super.ProcessorOnOpenDesc();
      }
      
      protected function ProcessorOnBuyUp(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode || this.FBeClicked)
         {
            return;
         }
         if(this.FWishTree.IsFailed == TWishTree.IS_FAILED)
         {
            _loc2_ = STRING_BASEACTIVITY.FORMAT_WISH_CONFIRMATION_BUY_WRONG;
            ProcessorEffectText(_loc2_);
            this.FUIWindowWishTreeBuyWrong.Visible = true;
            return;
         }
         if(this.FIsPlaying)
         {
            _loc2_ = STRING_BASEACTIVITY.FORMAT_WAIT_AMOUNT;
            ProcessorEffectText(_loc2_);
         }
         if(this.FWishTree.FreeTimes > 0)
         {
            PerformPacket_CS_AllReq(REQ_BUY_WISH);
         }
         else if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = this.FWishTree.WishPrice;
            FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
            FUIWindowConfirmation.SetCheckBox(true);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      override protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         if(this.FWishTree.IsCreditGoldEnough(this.FCost))
         {
            this.FBeClicked = true;
            PerformPacket_CS_AllReq(REQ_BUY_WISH);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function WindowConfirmationBuyWrongOnOK(param1:Object = null) : void
      {
         this.FCost = this.FWishTree.RewardList[this.FWishTree.CurLevel - 1].Price;
         if(!this.FWishTree.IsCreditGoldEnough(this.FCost))
         {
            FUIWindowRecharge.Visible = true;
            return;
         }
         this.FUIWindowWishTreeBuyWrong.Visible = false;
         PerformPacket_CS_AllReq(REQ_BUY_WRONG);
      }
      
      protected function WindowCofirmationBuyWrongOnCancel(param1:Object = null) : void
      {
         this.FUIWindowWishTreeBuyWrong.Visible = false;
         PerformPacket_CS_AllReq(REQ_CANCEL);
      }
      
      protected function ProcessorOnGetKillBoxUp(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         var _loc4_:Vector.<int> = null;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         FIndex = param1;
         _loc4_ = new Vector.<int>();
         _loc4_.push(FIndex + 1);
         PerformPacket_CS_AllReq(REQ_GET_REWARD,_loc4_);
      }
      
      protected function ProcessorOnCloseWindow() : void
      {
         this.FProcessorWishTreeRank.Visible = false;
         this.UpdateWindow();
      }
      
      protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(this.FWishTree.RewardList[0] != null)
         {
            this.FOverlayerItemAndPoint.Context = this.FWishTree.RewardList[_loc2_];
            this.FOverlayerItemAndPoint.Render(FUICore.MouseCoordinate);
            this.FOverlayerItemAndPoint.Show();
         }
      }
      
      protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         this.FOverlayerItemAndPoint.Hide();
      }
      
      protected function ProcessorOnBtnOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(param1.currentTarget.buttonMode)
         {
            _loc2_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_WISH_COST,this.FWishTree.WishPrice);
            ProcessorOnShowTip(_loc2_);
         }
         else
         {
            ProcessorOnShowTip(STRING_BASEACTIVITY.FORMAT_WISH_TIME_OUT);
         }
      }
      
      protected function ProcessorOnBtnOut(param1:MouseEvent) : void
      {
         FMC_Scene.BTN_Buy.gotoAndStop(1);
         ProcessorOnHideTip();
      }
      
      protected function ProcessorOnTitleOver(param1:uint) : void
      {
         var _loc2_:TTitle = null;
         _loc2_ = this.FAllTitles.GetTitleByIdentifier(param1);
         if(_loc2_ != null)
         {
            this.FOverlayerTitle.Context = _loc2_;
            this.FOverlayerTitle.Render(FUICore.MouseCoordinate);
            this.FOverlayerTitle.Show();
         }
      }
      
      protected function ProcessorOnTitleOut() : void
      {
         this.FOverlayerTitle.Hide();
      }
      
      override protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.WISH_TREE_PET) as TSystemLanguage;
         FHtmlHint.Content = _loc2_.Desc;
         UIHelpTipsHintOnOver(this,FHtmlHint);
      }
      
      override protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         UIHelpTipsHintOnOut(this);
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWishTreeRank.Load();
            this.FUIWindowWishTreeBuyWrong.Load();
            return;
         }
         this.visible = true;
         this.alpha = 1;
         if(FMC_EffectLeft)
         {
            FMC_EffectLeft.play();
         }
         if(FMC_EffectRight)
         {
            FMC_EffectRight.play();
         }
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FUIWindowWishTreeBuyWrong.Visible = false;
         if(Boolean(FMC_Scene) && Boolean(FMC_Scene.BTN_Buy.MC_FirstFrame))
         {
            FMC_Scene.BTN_Buy.MC_FirstFrame.stop();
         }
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         super.ProcessorOnLoadInfoRet();
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerWishTree.Unstreamize(_loc2_,this.FWishTree,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            if(FMC_Scene.BTN_Buy.MC_FirstFrame)
            {
               FMC_Scene.BTN_Buy.MC_FirstFrame.gotoAndPlay(1);
            }
            this.SetWishEndTime();
            this.UpdateUI();
         }
      }
      
      override public function ProcessorAllRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventories = null;
         var _loc9_:TInventory = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:uint = 0;
         var _loc15_:int = 0;
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         switch(_loc7_)
         {
            case REQ_BUY_WISH:
               if(this.FWishTree.FreeTimes > 0)
               {
                  --this.FWishTree.FreeTimes;
               }
               _loc2_.readShort();
               _loc8_ = new TInventories();
               _loc13_ = new Vector.<uint>();
               _loc15_ = int(_loc2_.readUnsignedInt());
               this.FWishTree.Point += _loc15_;
               _loc10_ = _loc2_.readUnsignedInt();
               _loc11_ = _loc2_.readUnsignedInt();
               _loc14_ = _loc2_.readUnsignedInt();
               this.FWishTree.CurLevel = _loc2_.readUnsignedInt();
               this.FWishTree.IsFailed = _loc2_.readUnsignedInt();
               _loc12_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,this.FArticleBins);
               _loc13_.push(_loc12_);
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc13_);
               _loc9_ = _loc8_.GetInventoryByIndex(0);
               if(this.FWishTree.IsFailed == TWishTree.IS_SUCCESSED)
               {
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_WISH_SUCCESS;
                  if(this.FWishTree.CurLevel == 1)
                  {
                     this.FMovieIndex = this.FWishTree.RewardList.length - 1;
                  }
                  else
                  {
                     this.FMovieIndex = this.FWishTree.CurLevel - 2;
                  }
                  this.PlayMovie();
               }
               else
               {
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_WISH_FAIL;
               }
               _loc4_ += STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc4_ = _loc4_ + (STRING_BASEACTIVITY.FORMAT_WISH_POINT + "*" + _loc15_ + "\n");
               _loc4_ = _loc4_ + (_loc9_.Name + "*" + _loc14_ + "\n");
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FWishTree.CheckStatus());
               this.UpdateUI();
               break;
            case REQ_BUY_WRONG:
               this.FWishTree.IsFailed = TWishTree.IS_SUCCESSED;
               this.FMovieIndex = this.FWishTree.CurLevel - 1;
               this.PlayMovie();
               ++this.FWishTree.CurLevel;
               this.UpdateUI();
               break;
            case REQ_CANCEL:
               this.FWishTree.CurLevel = 1;
               this.FWishTree.IsFailed = TWishTree.IS_SUCCESSED;
               this.UpdateUI();
               break;
            case REQ_GET_REWARD:
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET;
               ProcessorEffectText(_loc4_);
               this.FWishTree.KillBox[FIndex].Status = TBaseActivity.STATUS_GETED;
               this.FProcessorWishTreeRank.BeClicked = false;
               ProcessorCheckEffect(FActivityID,this.FWishTree.CheckStatus());
               this.UpdateUI();
         }
      }
      
      public function PlayMovie() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TInventories = null;
         _loc3_ = this.FBoxList[this.FMovieIndex];
         if(_loc3_)
         {
            this.FIsPlaying = true;
            this.FTotalFrame = _loc3_.totalFrames;
            _loc3_.gotoAndPlay(1);
         }
      }
      
      public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this.FBoxList[this.FMovieIndex].gotoAndStop(1);
         FMC_Scene.MC_Effect.gotoAndPlay(1);
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([1,0,0,0,0]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeUnsignedInt(1471571200);
         TUtilityString.FlushUTF(_loc3_,"许愿树");
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeShort(11);
         _loc1_ = 0;
         while(_loc1_ < 11)
         {
            TUtilityString.FlushUTF(_loc3_,"aaa");
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.writeShort(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 2);
            _loc3_.writeUnsignedInt(10010);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc1_++;
         }
         _loc3_.writeShort(6);
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 10);
            _loc3_.writeUnsignedInt(_loc1_ + 100);
            _loc3_.writeShort(3);
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc2_);
               _loc3_.writeUnsignedInt(1 + _loc2_);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public function TestInit1() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeUnsignedInt(20);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

