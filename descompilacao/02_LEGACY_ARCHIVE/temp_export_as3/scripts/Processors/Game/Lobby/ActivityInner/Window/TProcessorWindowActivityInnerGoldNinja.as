package Processors.Game.Lobby.ActivityInner.Window
{
   import Components.ScrollBar.TScrollBar;
   import Components.Slots.TUISlot;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.ActivityMode.TActivityAtom;
   import Logics.ActivityMode.TActivityAtoms;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Signals.TSignal;
   import Processors.Game.Lobby.ActivityInner.Components.TActivityReward;
   import Processors.Game.Lobby.ActivityInner.TProcessorWindowWonderfulActivity;
   import Resources.Constants.CONST_ACTIVITYINNER;
   import Resources.Constants.CONST_COUNTER;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SIGNAL;
   import Resources.Strings.STRING_ACTIVITYINNER;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowActivityInnerGoldNinja extends TProcessorWindowWonderfulActivity
   {
      
      protected static const CAPACITY_SLOTS:uint = 6;
      
      protected static const ROW_COUNT:uint = 4;
      
      protected static const MIN_SCROLL_HEIGHT:Number = 356;
      
      protected static const ITEM_STAMP:Number = 5;
      
      protected static const SINGLE_ITEM_STAMP:Number = 35;
      
      protected static const ITEM_HEIGHT:Number = 70;
      
      protected static const KEY_GoldNinja:uint = CONST_COUNTER.KEY_GoldNinja;
      
      protected static var FFormatExpression:RegExp = /\%(\d+)/g;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FTF_Title:TextField;
      
      protected var FMC_Detail:MovieClip;
      
      protected var FMC_Others:MovieClip;
      
      protected var FTF_Date:TextField;
      
      protected var FTF_Desc:TextField;
      
      protected var FTF_Time:TextField;
      
      protected var FBTN_Goto:SimpleButton;
      
      protected var FMC_Reward:MovieClip;
      
      protected var FMC_Top:MovieClip;
      
      protected var FMC_Bottom:MovieClip;
      
      protected var FMC_RANK:MovieClip;
      
      protected var FMC_List:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FInitialized:Boolean;
      
      protected var FActivityAtoms:TActivityAtoms;
      
      protected var FCountKey:Vector.<uint>;
      
      protected var FRewardList:Vector.<TActivityReward>;
      
      protected var FCurNinjaCount:Vector.<int>;
      
      protected var fIsShow:Boolean;
      
      protected var FOnGoto:Function;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      protected var FOnActiveInfoReq:Function;
      
      public function TProcessorWindowActivityInnerGoldNinja(param1:TUIComponent)
      {
         super(param1);
         this.FCurNinjaCount = new Vector.<int>(ROW_COUNT);
         this.FRewardList = new Vector.<TActivityReward>();
         this.FCountKey = new Vector.<uint>();
         this.FInitialized = false;
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         var _loc4_:int = 0;
         if(this.FInitialized && this.Visible)
         {
            this.FTF_Time.text = TGameUtil.fomatTime(this.FActivityAtoms.EndTime - STimingCore.GetServerTick());
            this.LogicsPerform_Signals();
            _loc4_ = 0;
            while(_loc4_ < this.FRewardList.length)
            {
               this.FRewardList[_loc4_].UpdateSlot();
               _loc4_++;
            }
         }
         super.LogicsPerform();
      }
      
      protected function LogicsPerform_Signals() : void
      {
         var _loc1_:TSignal = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc1_ = SLogicsCore.SignalRetrieve(CONST_SIGNAL.SIGNALDESTINATION_ACTIVE_GoldNinja_Ret);
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_ = _loc1_.Identifier;
         _loc3_ = uint(_loc1_.Value);
         switch(_loc2_)
         {
            case KEY_GoldNinja:
               this.FCurNinjaCount[0] = _loc3_;
               this.FCurNinjaCount[1] = _loc3_;
               this.FCurNinjaCount[2] = _loc3_;
               this.FCurNinjaCount[3] = _loc3_;
         }
         this.UpdateUI();
      }
      
      protected function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateReward();
      }
      
      protected function UpdateText() : void
      {
         if(!this.FInitialized || !this.FActivityAtoms)
         {
            return;
         }
         this.FTF_Title.text = this.FActivityAtoms.RightCaption;
         this.FTF_Desc.text = this.FActivityAtoms.Desc;
         this.FTF_Date.text = TUtilityString.Format(STRING_ACTIVITYINNER.FORMAT_ACTIVITYTIME,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FActivityAtoms.StartTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FActivityAtoms.EndTime - 1) * 1000)));
      }
      
      protected function UpdateReward() : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc7_:TInventory = null;
         var _loc8_:TInventories = null;
         var _loc9_:TActivityAtom = null;
         var _loc11_:int = 0;
         if(!this.FInitialized || !this.FActivityAtoms)
         {
            return;
         }
         var _loc1_:String = STRING_ACTIVITYINNER.STRING_PURPLE_COUNT;
         var _loc2_:String = STRING_ACTIVITYINNER.STRING_PURPLE_STATUS;
         var _loc10_:int = 0;
         while(_loc10_ < ROW_COUNT)
         {
            _loc3_ = TUtilityString.Format(_loc1_,this.FActivityAtoms.GetActivityAtomByIndex(_loc10_).ConditionValue[0]);
            _loc4_ = STRING_ACTIVITYINNER.STRING_GOLD_LEVEL[_loc10_];
            _loc5_ = TUtilityString.Format(_loc2_,this.FCurNinjaCount[_loc10_],this.FActivityAtoms.GetActivityAtomByIndex(_loc10_).ConditionValue[0]);
            this.FRewardList[_loc10_].SetText(_loc3_,_loc4_,_loc5_);
            this.FRewardList[_loc10_].SetTextFormat(1,1);
            _loc9_ = this.FActivityAtoms.GetActivityAtomByIndex(_loc10_);
            _loc8_ = _loc9_.InventoriesVect[0];
            _loc6_ = uint(_loc8_.Count);
            this.FRewardList[_loc10_].Identifier = _loc9_.Identifier;
            _loc11_ = 0;
            while(_loc11_ < _loc6_)
            {
               _loc7_ = _loc8_.GetInventoryByIndex(_loc11_);
               this.FRewardList[_loc10_].SetItemInfo(_loc11_,_loc7_);
               _loc11_++;
            }
            this.FRewardList[_loc10_].SetBt(_loc9_.ActiveStatus);
            _loc10_++;
         }
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = SResourcesCore.TexturesInventory;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_ActivityInner);
         }
      }
      
      protected function ProcessorOnGetReward(param1:Object, param2:uint) : void
      {
         if(FOnReceiveAwards != null)
         {
            FOnReceiveAwards(this,param2);
         }
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      protected function PerformPacket_CS_UpdateCounterReq() : void
      {
         this.FCountKey.push(KEY_GoldNinja);
         SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_ACTIVE_GoldNinja_Req,0,0,this.FCountKey);
      }
      
      protected function UILocations() : void
      {
         if(this.FBTN_Goto)
         {
            this.FBTN_Goto.addEventListener(MouseEvent.CLICK,this.ButtonGotoOnClick,false,0,true);
         }
      }
      
      protected function ButtonGotoOnClick(param1:MouseEvent) : void
      {
         JmpToWindow();
      }
      
      public function get FIsShow() : Boolean
      {
         return this.fIsShow;
      }
      
      public function set FIsShow(param1:Boolean) : void
      {
         this.fIsShow = param1;
      }
      
      public function get OnGoto() : Function
      {
         return this.FOnGoto;
      }
      
      public function set OnGoto(param1:Function) : void
      {
         this.FOnGoto = param1;
      }
      
      override public function UIDispatch(param1:MovieClip) : void
      {
         super.UIDispatch(param1);
         this.Init(param1);
      }
      
      public function Init(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TActivityReward = null;
         if(!param1)
         {
            return;
         }
         this.FMC_Scene = param1;
         addChild(this.FMC_Scene);
         this.FMC_Scene.visible = true;
         this.FTF_Title = this.FMC_Scene[CONST_ACTIVITYINNER.RESOURCE_LINK_TF_TITLE];
         this.FMC_Others = this.FMC_Scene[CONST_ACTIVITYINNER.RESOURCE_LINK_MC_OTHERS];
         this.FMC_Detail = this.FMC_Others[CONST_ACTIVITYINNER.RESOURCE_LINK_MC_DETAIL];
         this.FTF_Date = this.FMC_Detail[CONST_ACTIVITYINNER.RESOURCE_LINK_TF_DATE];
         this.FTF_Desc = this.FMC_Detail[CONST_ACTIVITYINNER.RESOURCE_LINK_TF_DESC];
         this.FTF_Time = this.FMC_Detail[CONST_ACTIVITYINNER.RESOURCE_LINK_TF_TIME];
         this.FBTN_Goto = this.FMC_Others[CONST_ACTIVITYINNER.RESOURCE_LINK_BTN_GOTO];
         this.FMC_Detail.addChild(this.FBTN_Goto);
         this.FMC_Reward = this.FMC_Others[CONST_ACTIVITYINNER.RESOURCE_LINK_MC_REWARD];
         this.FMC_Top = this.FMC_Reward[CONST_ACTIVITYINNER.RESOURCE_LINK_MC_TOP];
         this.FMC_Bottom = this.FMC_Reward[CONST_ACTIVITYINNER.RESOURCE_LINK_MC_BOTTOM];
         this.FMC_RANK = this.FMC_Top["Rank"];
         this.FMC_RANK.visible = false;
         _loc3_ = this.FRewardList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FRewardList.pop();
            _loc4_.parent.removeChild(_loc4_);
            _loc2_++;
         }
         this.FRewardList.length = 0;
         _loc3_ = ROW_COUNT;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = new TActivityReward(this,0,CAPACITY_SLOTS);
            _loc4_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc4_.OnOverlay = SlotOnOver;
            _loc4_.OnOut = SlotOnOut;
            _loc4_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc4_.OnGetReward = this.ProcessorOnGetReward;
            _loc4_.Init();
            _loc4_.y = this.FMC_Top.height + _loc2_ * ITEM_HEIGHT;
            this.FMC_Reward.addChild(_loc4_);
            this.FRewardList.push(_loc4_);
            _loc2_++;
         }
         this.FMC_Bottom.y = this.FRewardList.length * ITEM_HEIGHT + this.FMC_Top.height;
         this.FMC_List = this.FMC_Others[CONST_ACTIVITYINNER.RESOURCE_LINK_MC_LIST];
         this.FScrollBar = new TScrollBar(this.FMC_List,MIN_SCROLL_HEIGHT,false,ITEM_STAMP,SINGLE_ITEM_STAMP);
         this.FScrollBar.AddItem(this.FMC_Detail);
         this.FScrollBar.AddItem(this.FMC_Reward);
         this.UILocations();
         this.FInitialized = true;
      }
      
      override public function NotifyActivityAtoms(param1:TActivityAtoms) : void
      {
         super.NotifyActivityAtoms(param1);
         this.UpdateActivityInfo(param1);
      }
      
      public function UpdateActivityInfo(param1:TActivityAtoms) : void
      {
         this.FActivityAtoms = param1;
         this.FActivityAtoms.SortActivityAtoms();
         this.PerformPacket_CS_UpdateCounterReq();
         this.UpdateUI();
      }
   }
}

