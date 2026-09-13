package Processors.Game.Lobby.ActivityInner.Window
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
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
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.TimeCoolDown.TTimeCoolDown;
   import Processors.Game.Lobby.ActivityInner.Components.TActivityReward;
   import Processors.Game.Lobby.ActivityInner.TProcessorWindowWonderfulActivity;
   import Resources.Constants.CONST_ACTIVITYINNER;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_ACTIVITYINNER;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowActivityInnerProtagonist extends TProcessorWindowWonderfulActivity
   {
      
      protected var FScene:MovieClip;
      
      protected var FMC_List:MovieClip;
      
      protected var FTF_Title:TextField;
      
      protected var FTF_Date:TextField;
      
      protected var FTF_Desc:TextField;
      
      protected var FTF_Time:TextField;
      
      protected var FMC_Others:Sprite;
      
      protected var FMC_Detail:Sprite;
      
      protected var FMC_Reward:TActivityReward;
      
      protected var FBtn_Goto:SimpleButton;
      
      protected var FInitialized:Boolean;
      
      protected var FIsFirstReq:Boolean;
      
      protected var FIsReq:Boolean;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FActivityAtoms:TActivityAtoms;
      
      protected var FTimeCoolDown:TTimeCoolDown;
      
      protected var FRemainCount:uint;
      
      protected var FTime:uint;
      
      protected var FIsShow:Boolean;
      
      protected var FOnGoto:Function;
      
      public function TProcessorWindowActivityInnerProtagonist(param1:TUIComponent)
      {
         super(param1);
         this.FTimeCoolDown = new TTimeCoolDown(CONST_COMMON.TIME_COOLDOWN_Activity_CAMP);
         SLogicsCore.Character.TimeCoolDowns.Add(this.FTimeCoolDown);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         if(this.FInitialized)
         {
            this.FMC_Reward.UpdateSlot();
         }
         if(this.FActivityAtoms != null && this.FTF_Time != null)
         {
            _loc1_ = this.FActivityAtoms.EndTime - STimingCore.GetServerTick();
            this.FTF_Time.text = TGameUtil.fomatTime(_loc1_);
         }
         if(this.FIsShow)
         {
            if(STimingCore.TickCount - this.FTime >= 5000)
            {
               this.remainCountReq();
            }
         }
         super.LogicsPerform();
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FScene = param1;
         addChild(this.FScene);
         this.FMC_Others = this.FScene[CONST_ACTIVITYINNER.RESOURCE_LINK_MC_OTHERS];
         this.FTF_Title = this.FScene[CONST_ACTIVITYINNER.RESOURCE_LINK_TF_TITLE];
         this.FMC_Detail = this.FMC_Others[CONST_ACTIVITYINNER.RESOURCE_LINK_MC_DETAIL];
         this.FTF_Date = this.FMC_Detail[CONST_ACTIVITYINNER.RESOURCE_LINK_TF_DATE];
         this.FTF_Desc = this.FMC_Detail[CONST_ACTIVITYINNER.RESOURCE_LINK_TF_DESC];
         this.FTF_Time = this.FMC_Detail[CONST_ACTIVITYINNER.RESOURCE_LINK_TF_TIME];
         this.FBtn_Goto = this.FMC_Others[CONST_ACTIVITYINNER.RESOURCE_LINK_BTN_GOTO];
         this.FMC_Reward = new TActivityReward(this,1,6);
         this.FMC_Reward.y = this.FMC_Detail.height;
         this.FMC_Reward.OnGetReward = this.OnGetReward;
         this.FMC_Reward.OnOverlay = SlotOnOver;
         this.FMC_Reward.OnOut = SlotOnOut;
         this.FMC_Reward.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FMC_Reward.OnQuerySubscript = this.SlotsOnQuerySubscript;
         this.FMC_Reward.Init();
         this.FMC_List = this.FMC_Others[CONST_ACTIVITYINNER.RESOURCE_LINK_MC_LIST];
         this.FScrollBar = new TScrollBar(this.FMC_List,361,false,0);
         this.FScrollBar.AddItem(this.FMC_Detail);
         this.FScrollBar.AddItem(this.FMC_Reward);
         this.FBtn_Goto.addEventListener(MouseEvent.CLICK,this.BtOnGoto);
         this.FInitialized = true;
      }
      
      protected function updateText(param1:TActivityAtoms) : void
      {
         this.FTF_Title.text = param1.RightCaption;
         this.FTF_Desc.text = param1.Desc;
         this.FTF_Date.text = TUtilityString.Format(STRING_ACTIVITYINNER.FORMAT_ACTIVITYTIME,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(param1.StartTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(param1.EndTime - 1) * 1000)));
      }
      
      protected function updateRewardItem(param1:TActivityAtom) : void
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TInventory = null;
         var _loc6_:TInventories = null;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:uint = 0;
         _loc6_ = param1.InventoriesVect[0];
         _loc4_ = uint(_loc6_.Count);
         this.FMC_Reward.Identifier = param1.Identifier;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = _loc6_.GetInventoryByIndex(_loc3_);
            this.FMC_Reward.SetItemInfo(_loc3_,_loc5_);
            _loc3_++;
         }
         this.FMC_Reward.SetBt(param1.ActiveStatus);
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TInventory = null;
         if(param2 is TInventory)
         {
            _loc4_ = param2 as TInventory;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      protected function updateRewardText(param1:uint) : void
      {
         this.FMC_Reward.SetText(STRING_ACTIVITYINNER.STRING_RENJIE,STRING_ACTIVITYINNER.STRING_RENJIENAME,TUtilityString.Format(STRING_ACTIVITYINNER.FORMAT_REMAINCOUNT,param1));
         if(param1 == 0)
         {
            if(this.FActivityAtoms.GetActivityAtomByIndex(0).ActiveStatus != -1)
            {
               this.FMC_Reward.setFinish();
               this.FActivityAtoms.GetActivityAtomByIndex(0).ActiveStatus = 0;
            }
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
      
      protected function OnGetReward(param1:Object, param2:uint) : void
      {
         if(FOnReceiveAwards != null)
         {
            FOnReceiveAwards(this,param2);
         }
      }
      
      protected function remainCountReq() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         _loc4_ = this.FActivityAtoms.GetActivityAtomByIndex(0).Identifier;
         _loc1_ = 1002;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Activity_GlobelDataReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(_loc4_);
         _loc3_.writeUnsignedInt(_loc1_);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.FTime = STimingCore.TickCount;
      }
      
      protected function remainCountRet(param1:uint) : void
      {
         this.FRemainCount = param1;
         if(this.FMC_Reward == null)
         {
            return;
         }
         this.updateRewardText(this.FRemainCount);
      }
      
      private function BtOnGoto(param1:MouseEvent) : void
      {
         JmpToWindow(1);
      }
      
      private function SentReq(param1:TimerEvent) : void
      {
         this.remainCountReq();
      }
      
      override public function UIDispatch(param1:MovieClip) : void
      {
         super.UIDispatch(param1);
         this.Resources_UIDispatch(param1);
      }
      
      override public function NotifyActivityAtoms(param1:TActivityAtoms) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TActivityAtom = null;
         super.NotifyActivityAtoms(param1);
         this.FActivityAtoms = param1;
         this.updateText(this.FActivityAtoms);
         _loc2_ = uint(this.FActivityAtoms.Count);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.FActivityAtoms.GetActivityAtomByIndex(_loc3_);
            this.updateRewardItem(_loc4_);
            _loc3_++;
         }
         this.remainCountReq();
      }
      
      override public function Show() : void
      {
         super.Show();
         this.remainCountReq();
         this.FTime = STimingCore.TickCount;
         this.FIsShow = true;
      }
      
      override public function Hide() : void
      {
         super.Hide();
         this.FIsShow = false;
      }
      
      override public function NotifyPacketArrive(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc2_ = param1.Data;
         _loc5_ = _loc2_.readUnsignedInt();
         if(_loc5_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc5_);
            return;
         }
         _loc3_ = _loc2_.readUnsignedInt();
         _loc6_ = _loc2_.readUnsignedInt();
         _loc4_ = _loc2_.readUnsignedInt();
         this.remainCountRet(_loc4_);
      }
   }
}

