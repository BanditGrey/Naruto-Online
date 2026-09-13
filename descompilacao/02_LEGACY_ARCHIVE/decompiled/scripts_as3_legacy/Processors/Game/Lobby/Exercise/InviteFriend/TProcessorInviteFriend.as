package Processors.Game.Lobby.Exercise.InviteFriend
{
   import Components.Pages.TUIPage;
   import Externals.SExternalCore;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.InviteFriend.TInviteFriend;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerInviteFriend;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorInviteFriend extends TProcessorBaseActivity
   {
      
      public static const BOX_COUNT:int = 3;
      
      public static const RANK_COUNT:int = 8;
      
      protected var FInviteFriend:TInviteFriend;
      
      protected var FBeClicked:Boolean;
      
      protected var FUnstreamizerInviteFriend:TUnstreamizerInviteFriend;
      
      protected var FIsListVisible:Boolean;
      
      protected var FInviteBox:TUIBaseBox;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_ChangePage:MovieClip;
      
      protected var FUI_Left_Btn:MovieClip;
      
      protected var FUI_Right_Btn:MovieClip;
      
      protected var FTF_Page:TextField;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      public function TProcessorInviteFriend(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FInviteFriend = SLogicsCore.InviteFriend;
         this.FUnstreamizerInviteFriend = new TUnstreamizerInviteFriend();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         FMC_Scene.MC_Mask.visible = false;
         FMC_Scene.MC_List.visible = false;
         this.FInviteBox = new TUIBaseBox(this,BOX_COUNT);
         this.FInviteBox.Perform_UIDispatch(FMC_Scene["MC_Item"]);
         this.FInviteBox.OnOverlay = this.SlotsOnOver;
         this.FInviteBox.OnOut = this.SlotsOnOut;
         this.FUIPage = new TUIPage(this);
         this.FMC_ChangePage = FMC_Scene.MC_List["MC_ChangePage"];
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
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         FMC_Scene.BTN_SendFeed.addEventListener(MouseEvent.CLICK,this.ProcessorOnSendFeed);
         TGameUtil.setButtonMode(FMC_Scene.BTN_SendFeed,true);
         FMC_Scene.BTN_Invite.addEventListener(MouseEvent.CLICK,this.ProcessorOnInviteFriend);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Invite,true);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         FMC_Scene.MC_Box.buttonMode = true;
         FMC_Scene.MC_Box.addEventListener(MouseEvent.CLICK,this.ProcessorOnBoxUp);
         FMC_Scene.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnFreeBoxOver);
         FMC_Scene.MC_Box.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnFreeBoxOut);
         FMC_Scene.BTN_ShowList.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowList);
         FMC_Scene.MC_List.Btn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnHideList);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(FInitialized)
         {
            if(Boolean(FMC_Scene) && FMC_Scene.visible)
            {
               if(this.FInviteBox)
               {
                  this.FInviteBox.LogicsPerform();
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         super.UpdateUI();
         this.UpdateText();
         this.UpdateFeedBox();
         this.UpdateInviteBox();
         this.UpdateInviteList();
      }
      
      protected function UpdateText() : void
      {
         FTF_Desc.text = this.FInviteFriend.InviteBoxs[0].Desc1.split("%n").join("\n");
         FTF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FInviteFriend.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FInviteFriend.EndTime - 1) * 1000)));
      }
      
      protected function UpdateFeedBox() : void
      {
         if(this.FInviteFriend.FeedBoxStatus == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Box.MC_Got.visible = true;
            FMC_Scene.MC_Box.filters = [];
         }
         else if(this.FInviteFriend.FeedBoxStatus == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.MC_Box.MC_Got.visible = false;
            FMC_Scene.MC_Box.filters = [TGameUtil.highLightFilters];
         }
         else
         {
            FMC_Scene.MC_Box.MC_Got.visible = false;
            FMC_Scene.MC_Box.filters = [TGameUtil.GaryColorFilters];
         }
      }
      
      protected function UpdateInviteBox() : void
      {
         var _loc1_:TInventories = null;
         var _loc2_:int = 0;
         _loc2_ = this.FInviteFriend.CurIndex;
         if(_loc2_ >= this.FInviteFriend.InviteBoxs.length)
         {
            FMC_Scene.MC_Mask.visible = true;
         }
         else
         {
            FMC_Scene.MC_Mask.visible = false;
            _loc1_ = this.FInviteFriend.InviteBoxs[_loc2_].Inventories;
            this.FInviteBox.UpdateUI(_loc1_);
            FMC_Scene.TF_InviteCount.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_INVITE_FRIEND,Math.min(this.FInviteFriend.TotalInvite,this.FInviteFriend.InviteBoxs[_loc2_].Price),this.FInviteFriend.InviteBoxs[_loc2_].Price);
            if(this.FInviteFriend.InviteBoxs[_loc2_].Status == TBaseActivity.STATUS_CANGET)
            {
               TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
            }
            else
            {
               TGameUtil.setButtonMode(FMC_Scene.BTN_Get,false);
            }
         }
      }
      
      protected function UpdateInviteList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventories = null;
         var _loc6_:TConsumeRankInfo = null;
         var _loc7_:String = null;
         var _loc8_:MovieClip = null;
         var _loc9_:int = 0;
         this.FUIPage.TotalQuantity = this.FInviteFriend.InviteList.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < RANK_COUNT)
         {
            _loc9_ = _loc1_ + this.FCurPage * RANK_COUNT;
            _loc8_ = FMC_Scene.MC_List["MC_List" + _loc1_];
            if(_loc9_ < this.FInviteFriend.InviteList.length)
            {
               _loc8_.visible = true;
               _loc8_.TF_Name.visible = true;
               _loc8_.TF_Count.visible = true;
               _loc6_ = this.FInviteFriend.InviteList[_loc9_];
               FMC_Scene.MC_List["MC_List" + _loc1_].TF_Name.text = _loc6_.UserName;
               FMC_Scene.MC_List["MC_List" + _loc1_].TF_Count.text = TUtilityDate.FormatMMDDChineseNew(new Date(STimingCore.GetClientShowTime(_loc6_.Time) * 1000));
            }
            else
            {
               _loc8_.visible = false;
               _loc8_.TF_Name.visible = false;
               _loc8_.TF_Count.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateInviteList();
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnSendFeed(param1:MouseEvent) : void
      {
         var _loc2_:Object = null;
         SExternalCore.CallBackSendFeed = this.SendFeedCallBack;
         _loc2_ = SExternalCore.SendFeed();
      }
      
      protected function ProcessorOnInviteFriend(param1:MouseEvent) : void
      {
         var _loc2_:Object = null;
         SExternalCore.CallBackInviteFriend = this.InviteFriendCallBack;
         _loc2_ = SExternalCore.InviteFriend();
      }
      
      protected function ProcessorOnBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         if(this.FBeClicked)
         {
            return;
         }
         if(this.FInviteFriend.FeedBoxStatus != TBaseActivity.STATUS_CANGET)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_GetRewardReq);
         _loc2_.Data.writeUnsignedInt(FActivityID);
         _loc2_.Data.writeUnsignedInt(1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnGetUp(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FBeClicked)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_BuyBoxReq);
         _loc2_.Data.writeUnsignedInt(FActivityID);
         _loc2_.Data.writeUnsignedInt(1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnShowList(param1:MouseEvent) : void
      {
         this.FIsListVisible = !this.FIsListVisible;
         FMC_Scene.MC_List.visible = this.FIsListVisible;
      }
      
      protected function ProcessorOnHideList(param1:MouseEvent) : void
      {
         this.FIsListVisible = false;
         FMC_Scene.MC_List.visible = this.FIsListVisible;
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         UIComponentsHintOnOver(this,param2);
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         UIComponentsHintOnOut(this,param2);
      }
      
      protected function ProcessorOnFreeBoxOver(param1:MouseEvent) : void
      {
         if(Boolean(this.FInviteFriend.Inventories) && this.FInviteFriend.Inventories.Count > 0)
         {
            UIComponentsHintOnOver(this,this.FInviteFriend.Inventories.GetInventoryByIndex(0));
         }
      }
      
      protected function ProcessorOnFreeBoxOut(param1:MouseEvent) : void
      {
         if(Boolean(this.FInviteFriend.Inventories) && this.FInviteFriend.Inventories.Count > 0)
         {
            UIComponentsHintOnOut(this,this.FInviteFriend.Inventories.GetInventoryByIndex(0));
         }
      }
      
      public function SendFeedCallBack() : void
      {
         if(this.FInviteFriend.FeedBoxStatus == TBaseActivity.STATUS_CANNOTGET)
         {
            this.FInviteFriend.FeedBoxStatus = TBaseActivity.STATUS_CANGET;
         }
         this.UpdateFeedBox();
      }
      
      public function InviteFriendCallBack(param1:Object = null) : void
      {
         if(Boolean(param1) && param1 == 0)
         {
            if(param1 == 0)
            {
            }
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
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
         this.visible = false;
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
         this.FUnstreamizerInviteFriend.Unstreamize(_loc2_,this.FInviteFriend,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorGetRewardRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TInventories = null;
         var _loc6_:int = 0;
         var _loc7_:TBaseBox = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            this.UpdateUI();
            return;
         }
         _loc5_ = this.FInviteFriend.Inventories;
         _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
         _loc6_ = 0;
         while(_loc6_ < _loc5_.Count)
         {
            _loc4_ += _loc5_.GetInventoryByIndex(_loc6_).Name + "*" + _loc5_.GetInventoryByIndex(_loc6_).Quantity + "\n";
            _loc6_++;
         }
         ProcessorEffectText(_loc4_);
         this.FInviteFriend.FeedBoxStatus = TBaseActivity.STATUS_GETED;
         this.UpdateFeedBox();
         ProcessorCheckEffect(FActivityID,this.FInviteFriend.CheckStatus());
      }
      
      override public function ProcessorBuyBoxRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TInventory = null;
         var _loc6_:TInventories = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:Vector.<uint> = null;
         var _loc13_:Vector.<uint> = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc8_ = _loc2_.readShort();
         _loc7_ = int(_loc2_.readUnsignedInt());
         this.FInviteFriend.CurIndex = _loc7_;
         this.FInviteFriend.TotalInvite = _loc2_.readUnsignedInt();
         if(_loc7_ < this.FInviteFriend.InviteBoxs.length)
         {
            this.FInviteFriend.InviteBoxs[_loc7_].Status = _loc2_.readUnsignedInt();
         }
         else
         {
            this.FInviteFriend.InviteBoxs[_loc7_ - 1].Status = TBaseActivity.STATUS_GETED;
         }
         _loc4_ = STRING_BASEACTIVITY.FORMAT_GET;
         ProcessorEffectText(_loc4_);
         ProcessorCheckEffect(FActivityID,this.FInviteFriend.CheckStatus());
         this.UpdateInviteBox();
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([1,0,1,0,1]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         TUtilityString.FlushUTF(_loc3_,"描述1");
         TUtilityString.FlushUTF(_loc3_,"描述2");
         TUtilityString.FlushUTF(_loc3_,"描述3");
         _loc3_.writeInt(1000);
         _loc3_.writeInt(0);
         _loc3_.writeInt(1);
         _loc3_.writeInt(1);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            TUtilityString.FlushUTF(_loc3_,"1月1日");
            _loc3_.writeInt(1);
            _loc3_.writeShort(5);
            _loc2_ = 0;
            while(_loc2_ < 5)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc1_ + _loc2_);
               _loc3_.writeUnsignedInt(5);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            TUtilityString.FlushUTF(_loc3_,"摇钱树");
            TUtilityString.FlushUTF(_loc3_,"摇钱树描述");
            _loc3_.writeUnsignedInt((_loc1_ + 1) * 10);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 10);
            _loc3_.writeUnsignedInt((_loc1_ + 1) * 50);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeShort(1);
            _loc2_ = 0;
            while(_loc2_ < 1)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc1_ + _loc2_);
               _loc3_.writeUnsignedInt(5);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeUnsignedInt(11210009 + _loc1_);
            _loc3_.writeUnsignedInt(100 + _loc1_);
            _loc3_.writeUnsignedInt(_loc4_[_loc1_]);
            _loc3_.writeUnsignedInt(50);
            TUtilityString.FlushUTF(_loc3_,"忍者描述1");
            TUtilityString.FlushUTF(_loc3_,"忍者描述2");
            TUtilityString.FlushUTF(_loc3_,"忍者描述3");
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeUnsignedInt((_loc1_ + 1) * 10);
            _loc3_.writeUnsignedInt(10 + _loc1_);
            _loc3_.writeUnsignedInt(5 + _loc1_);
            _loc3_.writeUnsignedInt(_loc4_[_loc1_]);
            _loc3_.writeShort(5);
            _loc2_ = 0;
            while(_loc2_ < 5)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc1_ + _loc2_);
               _loc3_.writeUnsignedInt(5);
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
         _loc3_.writeUnsignedInt(0);
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

