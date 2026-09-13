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
   import Foundation.Utilities.TUtilityStandardBTN;
   import Foundation.Utilities.TUtilityString;
   import Logics.ActivityMode.TActivityAtom;
   import Logics.ActivityMode.TActivityAtoms;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Pet.TPet;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.ActivityInner.Components.TActivityNewRewardPsychicBeast;
   import Processors.Game.Lobby.ActivityInner.TProcessorWindowWonderfulActivity;
   import Processors.Game.Lobby.Jade.TJadeCommon;
   import Resources.Constants.CONST_ACTIVITYINNER;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_ACTIVITYINNER;
   import Resources.Strings.STRING_PSYCHICBEAST;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowActivityInnerPsychicBeast extends TProcessorWindowWonderfulActivity
   {
      
      protected static const CAPACITY_SLOTS:uint = 3;
      
      protected static const ROW_COUNT:uint = 5;
      
      protected static const MIN_SCROLL_HEIGHT:Number = 356;
      
      protected static const ITEM_STAMP:Number = 5;
      
      protected static const SINGLE_ITEM_STAMP:Number = 35;
      
      protected static const ITEM_HEIGHT:Number = 70;
      
      public static const PsychicBeastType:uint = 55;
      
      protected static var FFormatExpression:RegExp = /\%(\d+)/g;
      
      protected static const TEMPNUMBER:uint = 18100000;
      
      protected var FTF_MyPower:TextField;
      
      protected var FTF_GoalPower:TextField;
      
      protected var FRewardsSlot:Vector.<TUISlot>;
      
      protected var FBtn_Receive:MovieClip;
      
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
      
      protected var FMC_Power:MovieClip;
      
      protected var FBtn_CantRecive:MovieClip;
      
      protected var FTF_CantRecive:TextField;
      
      protected var FMC_List:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FInitialized:Boolean;
      
      protected var FActivityAtoms:TActivityAtoms;
      
      protected var FCountKey:Vector.<uint>;
      
      protected var FRewardList:Vector.<TActivityNewRewardPsychicBeast>;
      
      protected var FCurNCount:Vector.<int>;
      
      protected var fIsShow:Boolean;
      
      protected var FOnGoto:Function;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      protected var FOnActiveInfoReq:Function;
      
      public function TProcessorWindowActivityInnerPsychicBeast(param1:TUIComponent)
      {
         super(param1);
         this.FRewardList = new Vector.<TActivityNewRewardPsychicBeast>();
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
            _loc1_ = 0;
            while(_loc1_ < this.FRewardsSlot.length)
            {
               this.FRewardsSlot[_loc1_].Update();
               _loc1_++;
            }
         }
         super.LogicsPerform();
      }
      
      protected function LogicsPerform_Signals() : void
      {
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
         var _loc7_:uint = 0;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:TActivityAtom = null;
         var _loc11_:TActivityAtoms = null;
         if(!this.FInitialized || !this.FActivityAtoms)
         {
            return;
         }
         var _loc1_:String = STRING_ACTIVITYINNER.STRING_TALISMAN_COUNT;
         var _loc2_:String = STRING_ACTIVITYINNER.STRING_TALISMAN_STATUS;
         _loc6_ = (this.FActivityAtoms.Count - 1) / 3;
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc11_ = this.GetLevelData(_loc7_);
            this.FRewardList[_loc7_].ActivityAtoms = _loc11_;
            this.FRewardList[_loc7_].UpdateUI();
            _loc7_++;
         }
         this.FlushManualRecevieData();
      }
      
      public function GetLevelData(param1:int) : TActivityAtoms
      {
         var _loc2_:TActivityAtoms = null;
         var _loc3_:TActivityAtom = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = new TActivityAtoms(30);
         _loc4_ = (param1 + 1) * 3 + 1;
         _loc5_ = param1 * 3 + 1;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = this.FActivityAtoms.GetActivityAtomByIndex(_loc5_);
            _loc2_.Add(_loc3_);
            _loc5_++;
         }
         return _loc2_;
      }
      
      protected function FlushManualRecevieData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         var _loc4_:TActivityAtom = null;
         var _loc5_:int = 0;
         var _loc6_:TPet = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc4_ = this.FActivityAtoms.GetActivityAtomByIndex(0);
         _loc5_ = _loc4_.ActiveStatus;
         _loc3_ = this.FActivityAtoms.GetActivityAtomByIndex(0).InventoriesVect[0];
         _loc2_ = _loc3_.Count;
         _loc1_ = 0;
         while(_loc1_ < this.FRewardsSlot.length)
         {
            if(_loc1_ < _loc2_)
            {
               this.FRewardsSlot[_loc1_].Context = _loc3_.GetInventoryByIndex(_loc1_);
               this.FRewardsSlot[_loc1_].Resource.visible = true;
            }
            else
            {
               this.FRewardsSlot[_loc1_].Resource.visible = false;
            }
            _loc1_++;
         }
         if(_loc5_ == -1)
         {
            if(this.FBtn_Receive != null)
            {
               this.FBtn_Receive.visible = false;
               TGameUtil.setButtonMode(this.FBtn_Receive,false);
               this.FBtn_CantRecive.visible = true;
            }
         }
         else if(_loc5_ == 0)
         {
            if(this.FBtn_Receive != null)
            {
               this.FBtn_Receive.visible = true;
               this.FBtn_Receive.mouseEnabled = false;
               TGameUtil.setButtonMode(this.FBtn_Receive,false);
               this.FBtn_CantRecive.visible = false;
            }
         }
         else if(_loc5_ >= 1)
         {
            if(this.FBtn_Receive != null)
            {
               this.FBtn_Receive.visible = true;
               this.FBtn_Receive.mouseEnabled = true;
               TGameUtil.setButtonMode(this.FBtn_Receive,true);
               this.FBtn_CantRecive.visible = false;
            }
         }
         _loc6_ = SLogicsCore.Character.Pet;
         _loc7_ = (SLogicsCore.Character.Pet.PetID - TEMPNUMBER) / 100 + 1;
         _loc8_ = _loc6_.Star;
         this.FTF_MyPower.text = TUtilityString.Format(STRING_PSYCHICBEAST.STRING_MYLEVEL,_loc7_,_loc8_);
         this.FTF_GoalPower.text = TUtilityString.Format(STRING_PSYCHICBEAST.STRING_LOCALLEVEL,_loc4_.Tips[0]);
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
      }
      
      protected function UILocations() : void
      {
         if(this.FBTN_Goto)
         {
            this.FBTN_Goto.addEventListener(MouseEvent.CLICK,this.ButtonGotoOnClick,false,0,true);
         }
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn_Receive,this.ReceiveBtnClick);
      }
      
      protected function ButtonGotoOnClick(param1:MouseEvent) : void
      {
         JmpToWindow();
      }
      
      protected function ReceiveBtnClick(param1:MouseEvent) : void
      {
         if(FOnReceiveAwards != null)
         {
            FOnReceiveAwards(this,this.FActivityAtoms.GetActivityAtomByIndex(0).Identifier);
         }
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
         var _loc3_:TUISlot = null;
         var _loc4_:uint = 0;
         var _loc5_:TActivityNewRewardPsychicBeast = null;
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
         if(this.FBTN_Goto)
         {
            this.FMC_Detail.addChild(this.FBTN_Goto);
         }
         this.FMC_Power = this.FMC_Others["MyPower"];
         this.FTF_MyPower = this.FMC_Power["TF_MyPower"];
         this.FTF_GoalPower = this.FMC_Power["TF_GoalPower"];
         this.FBtn_CantRecive = this.FMC_Power["MC_Get"];
         this.FBtn_Receive = this.FMC_Power["BTN_GetReward"];
         this.FBtn_Receive.stop();
         this.FRewardsSlot = new Vector.<TUISlot>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_Power["MC_Slot_" + _loc2_];
            _loc3_.OnOut = SlotOnOut;
            _loc3_.OnOverlay = SlotOnOver;
            TJadeCommon.InitSlot(_loc3_,CONST_MODULES.MODULE_ActivityInner);
            _loc3_.Init();
            this.FRewardsSlot.push(_loc3_);
            _loc2_++;
         }
         this.FMC_Reward = this.FMC_Others[CONST_ACTIVITYINNER.RESOURCE_LINK_MC_REWARD];
         this.FMC_Top = this.FMC_Reward[CONST_ACTIVITYINNER.RESOURCE_LINK_MC_TOP];
         this.FMC_Bottom = this.FMC_Reward[CONST_ACTIVITYINNER.RESOURCE_LINK_MC_BOTTOM];
         _loc4_ = this.FRewardList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc5_ = this.FRewardList.pop();
            _loc5_.parent.removeChild(_loc5_);
            _loc2_++;
         }
         this.FRewardList.length = 0;
         _loc4_ = ROW_COUNT;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc5_ = new TActivityNewRewardPsychicBeast(this,_loc2_ + 1);
            _loc5_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc5_.OnOverlay = SlotOnOver;
            _loc5_.OnOut = SlotOnOut;
            _loc5_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc5_.OnGetReward = this.ProcessorOnGetReward;
            _loc5_.Init();
            _loc5_.y = this.FMC_Top.height + _loc2_ * _loc5_.height;
            this.FMC_Reward.addChild(_loc5_);
            this.FRewardList.push(_loc5_);
            _loc2_++;
         }
         this.FMC_Bottom.y = this.FRewardList.length * _loc5_.height + this.FMC_Top.height;
         this.FMC_List = this.FMC_Others[CONST_ACTIVITYINNER.RESOURCE_LINK_MC_LIST];
         this.FScrollBar = new TScrollBar(this.FMC_List,MIN_SCROLL_HEIGHT,false,ITEM_STAMP,SINGLE_ITEM_STAMP);
         this.FScrollBar.AddItem(this.FMC_Detail);
         this.FScrollBar.AddItem(this.FMC_Power);
         this.FScrollBar.AddItem(this.FMC_Reward);
         this.UILocations();
         this.FInitialized = true;
      }
      
      override public function NotifyActivityAtoms(param1:TActivityAtoms) : void
      {
         super.NotifyActivityAtoms(param1);
         this.FActivityAtoms = param1;
         this.UpdateActivityInfo(param1);
      }
      
      public function UpdateActivityInfo(param1:TActivityAtoms) : void
      {
         this.FActivityAtoms = param1;
         this.FActivityAtoms.SortActivityAtoms();
         this.UpdateUI();
      }
   }
}

