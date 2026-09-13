package Processors.Game.Lobby.Exercise.ActiveRank
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Exercise.BaseRank.TActiveRankDatas;
   import Logics.Exercise.BaseRank.TBaseRank;
   import Logics.Exercise.BaseRank.TRankInfo;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowPetDesc;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TProcessorActiveRank extends TProcessorLobbyWindow
   {
      
      protected static const SIZE_Window_Width:uint = 785;
      
      protected static const SIZE_Window_Height:uint = 533;
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      protected static const ACTIVITY_2_ID:int = 2;
      
      protected static const ACTIVITY_3_ID:int = 3;
      
      protected static const ACTIVITY_4_ID:int = 4;
      
      protected static const TAB_TYPE_0:int = 0;
      
      protected static const TAB_TYPE_1:int = 1;
      
      protected static const TAB_TYPE_2:int = 2;
      
      protected static const TAB_TYPE_3:int = 3;
      
      protected static const TAB_COUNT:int = 4;
      
      protected static const RANK_COUNT:int = 3;
      
      protected static const RANK_ITEM_COUNT:int = 3;
      
      protected static const LOG_COUNT:int = 3;
      
      protected static const LOG_ITEM_COUNT:int = 3;
      
      protected var FActiveRankDatas:TActiveRankDatas;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMC_RankList:MovieClip;
      
      protected var FMC_MyRank:MovieClip;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FInitialized:Boolean;
      
      protected var FUITab:TUITab;
      
      protected var FChangeTabIndex:int;
      
      protected var FBuyBoxDate:Object;
      
      protected var FUIPage0:TUIPage;
      
      protected var FTotalPage0:int;
      
      protected var FCurPage0:int;
      
      protected var FUIPage1:TUIPage;
      
      protected var FTotalPage1:int;
      
      protected var FCurPage1:int;
      
      protected var FRankItems:Vector.<TUIShowItem>;
      
      protected var FLogItems:Vector.<TUIShowItem>;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorWindowPetDesc:TProcessorWindowPetDesc;
      
      protected var FIsFirst:Boolean;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FTimeID:int;
      
      protected var FOnCloseUp:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      protected var FTitleHintOnOver:Function;
      
      protected var FTitleHintOnOut:Function;
      
      protected var FOnChangeTab:Function;
      
      protected var FOnShowRecruit:Function;
      
      public function TProcessorActiveRank(param1:TUIComponent)
      {
         super(param1);
         this.FActiveRankDatas = SLogicsCore.ActiveRankDatas;
         this.FUITab = new TUITab(this);
         this.FChangeTabIndex = 0;
         this.FUIPage0 = new TUIPage(this);
         this.FUIPage1 = new TUIPage(this);
         this.FRankItems = new Vector.<TUIShowItem>(RANK_COUNT * 2);
         this.FLogItems = new Vector.<TUIShowItem>(RANK_COUNT * 2);
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = this.ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = this.ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         this.FProcessorWindowPetDesc = new TProcessorWindowPetDesc(this.Parent);
         this.FProcessorWindowPetDesc.Visible = false;
         this.FProcessorWindowPetDesc.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowPetDesc.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         this.FIsFirst = true;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2550137121);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUIShowItem = null;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_BaseActiveRank2") as MovieClip;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene["Btn_Close"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            this.FUITab.SetTabByIndex(this.FMC_Scene["BTN_Tab" + _loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.ChangeTabOnSwitch;
         this.FUITab.Init();
         this.FMC_RankList = this.FMC_Scene.MC_Tab0;
         this.FMC_MyRank = this.FMC_Scene.MC_Tab1;
         this.FUIPage0.ButtonPrevious.Substrate = this.FMC_RankList.MC_ChangePage.MC_PageLeft;
         this.FUIPage0.ButtonNext.Substrate = this.FMC_RankList.MC_ChangePage.MC_PageRight;
         this.FUIPage0.LabelPage = this.FMC_RankList.MC_ChangePage.TF_Page;
         this.FUIPage0.TotalQuantity = this.FTotalPage0;
         this.FUIPage0.PageSize = RANK_COUNT;
         this.FUIPage0.PageIndex = 0;
         this.FUIPage0.OnChangePage = this.ProcessorPageOnChange0;
         this.FCurPage0 = 0;
         this.FUIPage1.ButtonPrevious.Substrate = this.FMC_MyRank.MC_ChangePage.MC_PageLeft;
         this.FUIPage1.ButtonNext.Substrate = this.FMC_MyRank.MC_ChangePage.MC_PageRight;
         this.FUIPage1.LabelPage = this.FMC_MyRank.MC_ChangePage.TF_Page;
         this.FUIPage1.TotalQuantity = this.FTotalPage1;
         this.FUIPage1.PageSize = LOG_COUNT;
         this.FUIPage1.PageIndex = 0;
         this.FUIPage1.OnChangePage = this.ProcessorPageOnChange1;
         this.FCurPage1 = 0;
         _loc1_ = 0;
         while(_loc1_ < RANK_COUNT * 2)
         {
            _loc2_ = _loc1_ / 2;
            _loc3_ = new TUIShowItem(this,RANK_ITEM_COUNT);
            if(_loc1_ % 2 == 0)
            {
               _loc3_.Perform_UIDispatch(this.FMC_RankList["MC_Item" + _loc2_].MC_Reward);
            }
            else
            {
               _loc3_.Perform_UIDispatch(this.FMC_RankList["MC_Item" + _loc2_].MC_Special);
            }
            _loc3_.OnOverlay = this.SlotsOnOver;
            _loc3_.OnOut = this.SlotsOnOut;
            _loc3_.OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FRankItems[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < LOG_COUNT * 2)
         {
            _loc2_ = _loc1_ / 2;
            _loc3_ = new TUIShowItem(this,LOG_ITEM_COUNT);
            if(_loc1_ % 2 == 0)
            {
               _loc3_.Perform_UIDispatch(this.FMC_MyRank["MC_Item" + _loc2_].MC_Reward);
            }
            else
            {
               _loc3_.Perform_UIDispatch(this.FMC_MyRank["MC_Item" + _loc2_].MC_Special);
            }
            _loc3_.OnOverlay = this.SlotsOnOver;
            _loc3_.OnOut = this.SlotsOnOut;
            _loc3_.OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FLogItems[_loc1_] = _loc3_;
            _loc1_++;
         }
         this.FOverlayerHint = new TOverlayerHint(this.Parent);
         this.FOverlayerHint.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnClose);
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateView() : void
      {
         switch(this.FChangeTabIndex)
         {
            case TAB_TYPE_0:
            case TAB_TYPE_1:
            case TAB_TYPE_2:
               this.FMC_RankList.visible = true;
               this.FMC_MyRank.visible = false;
               this.UpdateRankList();
               break;
            case TAB_TYPE_3:
               this.FMC_RankList.visible = false;
               this.FMC_MyRank.visible = true;
               this.UpdateMyRank();
         }
      }
      
      protected function UpdateRankList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TRankInfo = null;
         var _loc6_:TBaseRank = null;
         var _loc7_:MovieClip = null;
         var _loc8_:TInventories = null;
         var _loc9_:TInventories = null;
         var _loc10_:int = 0;
         _loc6_ = this.FActiveRankDatas.GetRankByIdentify(this.FChangeTabIndex + 1);
         this.FUIPage0.TotalQuantity = _loc6_.RankList.length;
         this.FUIPage0.Update();
         if(this.FMC_RankList.MC_End)
         {
            if(this.FChangeTabIndex == 0 && this.FActiveRankDatas.IsEnd == 1)
            {
               this.FMC_RankList.MC_End.visible = true;
            }
            else
            {
               this.FMC_RankList.MC_End.visible = false;
            }
         }
         _loc1_ = 0;
         while(_loc1_ < RANK_COUNT)
         {
            _loc3_ = _loc1_ + this.FCurPage0 * RANK_COUNT;
            _loc7_ = this.FMC_RankList["MC_Item" + _loc1_];
            if(_loc3_ < _loc6_.RankList.length)
            {
               _loc7_.visible = true;
               _loc5_ = _loc6_.RankList[_loc3_];
               _loc7_.TF_Rank.text = _loc5_.Rank.toString();
               _loc7_.TF_Name.text = _loc5_.Name;
               _loc7_.TF_Score.text = _loc5_.Score.toString();
               _loc7_.TF_Price.text = this.FActiveRankDatas.GetCommandStringByType(this.FChangeTabIndex + 1,_loc5_.RewardIndex - 1);
               _loc8_ = this.FActiveRankDatas.GetInventoriesByType(this.FChangeTabIndex + 1,0,_loc5_.RewardIndex - 1);
               if(_loc8_)
               {
                  _loc7_.MC_None0.visible = _loc8_.Count > 0 ? false : true;
               }
               else
               {
                  _loc7_.MC_None0.visible = true;
               }
               this.FRankItems[_loc1_ * 2].UpdateUI(_loc8_);
               _loc9_ = this.FActiveRankDatas.GetInventoriesByType(this.FChangeTabIndex + 1,1,_loc5_.RewardIndex - 1);
               if(_loc9_)
               {
                  _loc7_.MC_None1.visible = _loc9_.Count > 0 ? false : true;
               }
               else
               {
                  _loc7_.MC_None1.visible = true;
               }
               this.FRankItems[_loc1_ * 2 + 1].UpdateUI(_loc9_);
               if(Boolean(_loc9_) && Boolean(_loc9_.Count > 0) && _loc5_.SpecialStatus == 0)
               {
                  _loc7_.MC_Miss.visible = true;
               }
               else
               {
                  _loc7_.MC_Miss.visible = false;
               }
            }
            else
            {
               _loc7_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateMyRank() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TRankInfo = null;
         var _loc6_:TBaseRank = null;
         var _loc7_:MovieClip = null;
         var _loc8_:TInventories = null;
         var _loc9_:TInventories = null;
         var _loc10_:int = 0;
         _loc6_ = this.FActiveRankDatas.GetRankByIdentify(this.FChangeTabIndex + 1);
         this.FUIPage1.TotalQuantity = _loc6_.RankList.length;
         this.FUIPage1.Update();
         _loc1_ = 0;
         while(_loc1_ < LOG_COUNT)
         {
            _loc3_ = _loc1_ + this.FCurPage1 * LOG_COUNT;
            _loc7_ = this.FMC_MyRank["MC_Item" + _loc1_];
            if(_loc3_ < _loc6_.RankList.length)
            {
               _loc7_.visible = true;
               _loc5_ = _loc6_.RankList[_loc3_];
               _loc7_.TF_Date.text = TUtilityDate.FormatDateChineseNew(new Date(_loc5_.RankDate * 1000));
               if(_loc5_.Rank == 0)
               {
                  _loc7_.TF_Rank.text = STRING_BASEACTIVITY.FORMAT_NEVER_IN_RANK;
               }
               else
               {
                  _loc7_.TF_Rank.text = _loc5_.Rank.toString();
               }
               _loc7_.TF_Score.text = _loc5_.Score.toString();
               _loc7_.TF_Price.text = this.FActiveRankDatas.GetCommandStringByType(this.FChangeTabIndex + 1,_loc5_.RewardIndex - 1);
               _loc8_ = this.FActiveRankDatas.GetInventoriesByType(this.FChangeTabIndex + 1,0,_loc5_.RewardIndex - 1);
               if(_loc8_)
               {
                  _loc7_.MC_None0.visible = _loc8_.Count > 0 ? false : true;
               }
               else
               {
                  _loc7_.MC_None0.visible = true;
               }
               this.FLogItems[_loc1_ * 2].UpdateUI(_loc8_);
               _loc9_ = this.FActiveRankDatas.GetInventoriesByType(this.FChangeTabIndex + 1,1,_loc5_.RewardIndex - 1);
               if(_loc9_)
               {
                  _loc7_.MC_None1.visible = _loc9_.Count > 0 ? false : true;
               }
               else
               {
                  _loc7_.MC_None1.visible = true;
               }
               this.FLogItems[_loc1_ * 2 + 1].UpdateUI(_loc9_);
               if(Boolean(_loc9_) && Boolean(_loc9_.Count > 0) && _loc5_.SpecialStatus == 0)
               {
                  _loc7_.MC_Miss.visible = true;
               }
               else
               {
                  _loc7_.MC_Miss.visible = false;
               }
            }
            else
            {
               _loc7_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         this.FMC_Scene.TF_Desc.text = this.FActiveRankDatas.DescListNew[0];
         this.FMC_Scene.TF_TotalScore.text = this.FActiveRankDatas.TotalScore.toString();
         if(this.FActiveRankDatas.TotalRank == 0)
         {
            this.FMC_Scene.TF_TotalRank.text = STRING_BASEACTIVITY.FORMAT_NEVER_IN_RANK;
         }
         else
         {
            this.FMC_Scene.TF_TotalRank.text = this.FActiveRankDatas.TotalRank.toString();
         }
         this.FMC_Scene.TF_TodayScore.text = this.FActiveRankDatas.TodayScore.toString();
         if(this.FActiveRankDatas.TodayRank == 0)
         {
            this.FMC_Scene.TF_TodayRank.text = STRING_BASEACTIVITY.FORMAT_NEVER_IN_RANK;
         }
         else
         {
            this.FMC_Scene.TF_TodayRank.text = this.FActiveRankDatas.TodayRank.toString();
         }
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         super.LogicsPerform();
         if(Boolean(this.visible) && Boolean(this.FMC_Scene) && this.FMC_Scene.visible)
         {
            if(this.FRankItems)
            {
               _loc1_ = 0;
               while(_loc1_ < this.FRankItems.length)
               {
                  this.FRankItems[_loc1_].LogicsPerform();
                  _loc1_++;
               }
            }
            if(this.FLogItems)
            {
               _loc1_ = 0;
               while(_loc1_ < this.FLogItems.length)
               {
                  this.FLogItems[_loc1_].LogicsPerform();
                  _loc1_++;
               }
            }
            if(this.FProcessorWindowRecruit != null && this.FProcessorWindowRecruit.Visible == true)
            {
               this.FProcessorWindowRecruit.UpdataBitmap();
            }
            if(this.FProcessorWindowPetDesc != null && this.FProcessorWindowPetDesc.Visible == true)
            {
               this.FProcessorWindowPetDesc.UpdataBitmap();
            }
         }
      }
      
      private function ProcessorOnClose(param1:MouseEvent) : void
      {
         if(this.FOnCloseUp != null)
         {
            this.FOnCloseUp();
         }
      }
      
      protected function ChangeTabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         if(_loc2_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc2_;
         this.FCurPage0 = 0;
         this.FUIPage0.PageIndex = 0;
         this.ProcessorOnLoadActiveRank();
      }
      
      protected function ProcessorPageOnChange0(param1:Object, param2:int) : void
      {
         this.FCurPage0 = param2;
         this.UpdateRankList();
      }
      
      protected function ProcessorPageOnChange1(param1:Object, param2:int) : void
      {
         this.FCurPage1 = param2;
         this.UpdateMyRank();
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(this.FOnOverlay != null)
         {
            this.FOnOverlay(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(this,param2);
         }
      }
      
      protected function ProcessorTipOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHint.Context = param2;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Show();
      }
      
      protected function ProcessorTipOnOut(param1:Object) : void
      {
         this.FOverlayerHint.Hide();
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int = 0) : void
      {
         if(param2 == TBaseBox.TYPE_IS_HERO)
         {
            this.FProcessorWindowRecruit.SetHeroData(param1);
         }
         else if(param2 == TBaseBox.TYPE_IS_PET)
         {
            this.FProcessorWindowPetDesc.SetPetData(param1);
         }
      }
      
      protected function SetInterval() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this.FTimeID != 0)
         {
            clearTimeout(this.FTimeID);
            this.FTimeID = 0;
         }
         var _loc1_:Date = new Date(STimingCore.GetServerTime() * 1000);
         _loc1_.hours = 0;
         _loc1_.minutes = 0;
         _loc1_.seconds = 0;
         _loc3_ = _loc1_.getTime() + 24 * 60 * 60 * 1000 + 5000;
         _loc2_ = _loc3_ - STimingCore.GetServerTime() * 1000;
         this.FTimeID = setTimeout(this.ProcessorOnLoadActiveRank,_loc2_);
      }
      
      public function get OnCloseUp() : Function
      {
         return this.FOnCloseUp;
      }
      
      public function set OnCloseUp(param1:Function) : void
      {
         this.FOnCloseUp = param1;
      }
      
      public function get OnOverlay() : Function
      {
         return this.FOnOverlay;
      }
      
      public function set OnOverlay(param1:Function) : void
      {
         this.FOnOverlay = param1;
      }
      
      public function get OnOut() : Function
      {
         return this.FOnOut;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FOnOut = param1;
      }
      
      public function get TipOnOver() : Function
      {
         return this.FTipOnOver;
      }
      
      public function set TipOnOver(param1:Function) : void
      {
         this.FTipOnOver = param1;
      }
      
      public function get TipOnOut() : Function
      {
         return this.FTipOnOut;
      }
      
      public function set TipOnOut(param1:Function) : void
      {
         this.FTipOnOut = param1;
      }
      
      public function get TitleHintOnOver() : Function
      {
         return this.FTitleHintOnOver;
      }
      
      public function set TitleHintOnOver(param1:Function) : void
      {
         this.FTitleHintOnOver = param1;
      }
      
      public function get TitleHintOnOut() : Function
      {
         return this.FTitleHintOnOut;
      }
      
      public function set TitleHintOnOut(param1:Function) : void
      {
         this.FTitleHintOnOut = param1;
      }
      
      public function get OnChangeTab() : Function
      {
         return this.FOnChangeTab;
      }
      
      public function set OnChangeTab(param1:Function) : void
      {
         this.FOnChangeTab = param1;
      }
      
      public function get OnShowRecruit() : Function
      {
         return this.FOnShowRecruit;
      }
      
      public function set OnShowRecruit(param1:Function) : void
      {
         this.FOnShowRecruit = param1;
      }
      
      public function UpdateUI() : void
      {
         this.UpdateView();
         this.UpdateText();
         if(this.FIsFirst)
         {
            this.FProcessorWindowRecruit.Load();
            this.FProcessorWindowPetDesc.Load();
            this.FIsFirst = false;
         }
         this.SetInterval();
      }
      
      public function ProcessorOnLoadActiveRank() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         if(this.FChangeTabIndex + 1 == 4)
         {
            _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActive_LoadRankLogReq);
         }
         else
         {
            _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActive_LoadRankReq);
         }
         _loc1_.Data.writeUnsignedInt(this.FActiveRankDatas.ActivityID);
         _loc1_.Data.writeUnsignedInt(this.FActiveRankDatas.ActivityIndex);
         _loc1_.Data.writeShort(1);
         _loc1_.Data.writeUnsignedInt(this.FChangeTabIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
   }
}

