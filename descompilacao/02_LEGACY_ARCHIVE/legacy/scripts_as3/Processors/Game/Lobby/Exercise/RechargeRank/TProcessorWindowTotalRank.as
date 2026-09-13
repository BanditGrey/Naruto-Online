package Processors.Game.Lobby.Exercise.RechargeRank
{
   import Components.Pages.TUIPage;
   import Components.ScrollBar.TScrollBar;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.RechargeRank.TRechargeRank;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.RechargeRank.Compoents.TUIRankReward;
   import Resources.Constants.CONST_RECHARGERANK;
   import Resources.Strings.STRING_RECHARGERANK;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowTotalRank extends TProcessorLobbyWindow
   {
      
      protected static const MAX_COUNT:int = 12;
      
      protected static const RANK_COUNT:int = 50;
      
      protected static const MIN_SCROLL_HEIGHT:Number = 196;
      
      protected static const ITEM_STAMP:Number = 0;
      
      protected static const SINGLE_ITEM_STAMP:Number = 60;
      
      protected static const ITEM_HEIGHT:Number = 60;
      
      protected static const INIT_X:Number = 0;
      
      protected static const INIT_Y:Number = 2;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMC_RankList:Sprite;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_ChangePage:MovieClip;
      
      protected var FUI_Left_Btn:MovieClip;
      
      protected var FUI_Right_Btn:MovieClip;
      
      protected var FTF_Page:TextField;
      
      protected var FTotalPage:int = 5;
      
      protected var FCurPage:int;
      
      protected var FRankList:Vector.<Sprite>;
      
      protected var FRewardList:Vector.<TUIRankReward>;
      
      protected var FTF_CurScore:TextField;
      
      protected var FTF_DiffScore:TextField;
      
      protected var FMC_CurRank:MovieClip;
      
      protected var FTF_Rank:TextField;
      
      protected var FInitialized:Boolean;
      
      protected var FRechargeRank:TRechargeRank;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FOnNameUp:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnShowRecruit:Function;
      
      protected var FOnShowDesc:Function;
      
      protected var FOnShowEquip:Function;
      
      public function TProcessorWindowTotalRank(param1:TUIComponent)
      {
         super(param1);
         this.FUIPage = new TUIPage(this);
         this.FRankList = new Vector.<Sprite>(MAX_COUNT);
         this.FRewardList = new Vector.<TUIRankReward>();
         this.FRechargeRank = SLogicsCore.RechargeRank;
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Sprite = null;
         var _loc5_:MovieClip = null;
         this.FMC_Scene = param1;
         addChild(this.FMC_Scene);
         this.FMC_RankList = this.FMC_Scene["MC_RankList"];
         _loc2_ = 0;
         while(_loc2_ < MAX_COUNT)
         {
            _loc4_ = this.FMC_RankList[CONST_RECHARGERANK.RESOURCE_Link_MC_Rank + _loc2_];
            _loc4_.buttonMode = false;
            _loc4_.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnNameUp,false,0,true);
            this.FRankList[_loc2_] = _loc4_;
            _loc2_++;
         }
         _loc5_ = this.FMC_Scene["MC_RewardList"];
         this.FScrollBar = new TScrollBar(_loc5_.mc_list,MIN_SCROLL_HEIGHT,false,ITEM_STAMP,SINGLE_ITEM_STAMP);
         this.FShowItem = new TUIShowItem(this,3);
         this.FShowItem.Perform_UIDispatch(this.FMC_Scene.MC_ShowItems);
         this.FShowItem.OnOverlay = this.SlotsOnOver;
         this.FShowItem.OnOut = this.SlotsOnOut;
         this.FShowItem.OnShowRecruit = this.OnShowDesc;
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_EquipDesc,true);
         this.FMC_Scene.BTN_EquipDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowEquipDesc);
         this.ResourcesPerform_UIDispatchChangePage();
         this.ResourcesPerform_UIDispatchText();
      }
      
      protected function ResourcesPerform_UIDispatchChangePage() : void
      {
         this.FMC_ChangePage = this.FMC_RankList[CONST_RECHARGERANK.RESOURCE_Link_MC_ChangePage];
         this.FUI_Left_Btn = this.FMC_ChangePage["MC_PageLeft"];
         this.FUI_Right_Btn = this.FMC_ChangePage["MC_PageRight"];
         this.FTF_Page = this.FMC_ChangePage["TF_Page"];
         this.FUIPage.ButtonPrevious.Substrate = this.FUI_Left_Btn;
         this.FUIPage.ButtonNext.Substrate = this.FUI_Right_Btn;
         this.FUIPage.LabelPage = this.FTF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = MAX_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
      }
      
      protected function ResourcesPerform_UIDispatchText() : void
      {
         this.FTF_CurScore = this.FMC_Scene.TF_CurScore;
         this.FTF_DiffScore = this.FMC_Scene.TF_DiffScore;
         this.FMC_CurRank = this.FMC_Scene.MC_CurRank;
         this.FTF_Rank = this.FMC_CurRank.TF_Rank;
      }
      
      protected function UpdateReward() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIRankReward = null;
         if(!this.FRewardList || this.FRewardList.length == 0)
         {
            _loc2_ = this.FRechargeRank.RankRewardList.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = new TUIRankReward(this);
               _loc3_.OnOverlay = this.SlotsOnOver;
               _loc3_.OnOut = this.SlotsOnOut;
               _loc3_.Init();
               _loc3_.y = INIT_Y + _loc1_ * ITEM_HEIGHT;
               _loc3_.SetItemInfo(_loc1_);
               this.FRewardList.push(_loc3_);
               this.FScrollBar.AddItem(_loc3_);
               _loc1_++;
            }
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
         var _loc7_:TextField = null;
         this.FUIPage.TotalQuantity = this.FRechargeRank.RankInfoList.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * MAX_COUNT;
            _loc3_ = this.FMC_RankList[CONST_RECHARGERANK.RESOURCE_Link_MC_Rank + _loc1_];
            _loc4_ = _loc3_.TF_Rank;
            _loc5_ = _loc3_.TF_ServerID;
            _loc6_ = _loc3_.TF_Name;
            _loc7_ = _loc3_.TF_Score;
            if(_loc2_ < this.FRechargeRank.RankInfoList.length)
            {
               _loc4_.visible = true;
               _loc5_.visible = true;
               _loc6_.visible = true;
               _loc7_.visible = true;
               _loc4_.text = this.FRechargeRank.RankInfoList[_loc2_].Rank.toString();
               _loc5_.text = this.FRechargeRank.RankInfoList[_loc2_].ServerID;
               _loc6_.text = this.FRechargeRank.RankInfoList[_loc2_].UserName;
               _loc7_.text = this.FRechargeRank.RankInfoList[_loc2_].Score.toString();
            }
            else
            {
               _loc4_.visible = false;
               _loc5_.visible = false;
               _loc6_.visible = false;
               _loc7_.visible = false;
            }
            _loc3_.MC_Background.visible = false;
            _loc1_++;
         }
         this.FShowItem.UpdateUI(this.FRechargeRank.RechargeShowItems);
      }
      
      protected function UpdateText() : void
      {
         this.FTF_CurScore.text = TUtilityString.Format(STRING_RECHARGERANK.FORMAT_CUR_SCORE,this.FRechargeRank.PerScore);
         if(this.FRechargeRank.PerRank == 1)
         {
            this.FTF_DiffScore.visible = false;
         }
         else if(this.FRechargeRank.PerRank > RANK_COUNT)
         {
            this.FTF_DiffScore.visible = true;
            this.FTF_DiffScore.text = TUtilityString.Format(STRING_RECHARGERANK.FORMAT_DIFF_FIFTY_SCORE,this.FRechargeRank.DiffScore);
         }
         else
         {
            this.FTF_DiffScore.visible = true;
            this.FTF_DiffScore.text = TUtilityString.Format(STRING_RECHARGERANK.FORMAT_DIFF_SCORE,this.FRechargeRank.DiffScore);
         }
         if(this.FRechargeRank.PerRank > RANK_COUNT)
         {
            this.FTF_Rank.text = STRING_RECHARGERANK.FORMAT_CUR_RANK;
         }
         else
         {
            this.FTF_Rank.text = this.FRechargeRank.PerRank.toString();
         }
         if(this.FRechargeRank.CurReturn > 0)
         {
            this.FMC_Scene.TF_CurReturn.text = this.FRechargeRank.CurReturn + "%";
         }
         else
         {
            this.FMC_Scene.TF_CurReturn.text = STRING_RECHARGERANK.FORMAT_NONE_RATE;
         }
         if(this.FRechargeRank.DiffGold > 0)
         {
            this.FMC_Scene.TF_NextReturn.text = TUtilityString.Format(this.FRechargeRank.Desc4,this.FRechargeRank.DiffGold,this.FRechargeRank.NextReturn);
         }
         else
         {
            this.FMC_Scene.TF_NextReturn.text = "";
         }
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.FInitialized && this.Visible)
         {
            _loc2_ = int(this.FRewardList.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FRewardList[_loc1_].UpdateSlot();
               _loc1_++;
            }
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
         }
         super.LogicsPerform();
      }
      
      protected function OnShowDesc(param1:uint, param2:int = 0) : void
      {
         if(this.FOnShowRecruit != null)
         {
            this.FOnShowRecruit(param1,param2);
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateUI();
      }
      
      protected function ProcessorOnNameUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         _loc3_ = _loc2_ + this.FCurPage * MAX_COUNT;
         if(this.FOnNameUp != null)
         {
            this.FOnNameUp(this.FRechargeRank.RankInfoList[_loc3_].Identify0,this.FRechargeRank.RankInfoList[_loc3_].Identify1);
         }
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
      
      protected function ProcessorOnShowDescUp(param1:MouseEvent) : void
      {
         if(this.FOnShowDesc != null)
         {
            this.FOnShowDesc();
         }
      }
      
      protected function ProcessorOnShowEquipDesc(param1:uint, param2:int = 0) : void
      {
         if(this.FOnShowEquip != null)
         {
            this.FOnShowEquip(this.FRechargeRank.RechargeEquipments);
         }
      }
      
      public function get OnNameUp() : Function
      {
         return this.FOnNameUp;
      }
      
      public function set OnNameUp(param1:Function) : void
      {
         this.FOnNameUp = param1;
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
      
      public function get OnShowRecruit() : Function
      {
         return this.FOnShowRecruit;
      }
      
      public function set OnShowRecruit(param1:Function) : void
      {
         this.FOnShowRecruit = param1;
      }
      
      public function set OnShowEquip(param1:Function) : void
      {
         this.FOnShowEquip = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function UpdateUI() : void
      {
         this.UpdateRank();
         this.UpdateReward();
         this.UpdateText();
      }
   }
}

