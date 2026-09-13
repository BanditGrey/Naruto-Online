package Processors.Game.Lobby.Organization
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TOrganizationDevotion;
   import Logics.SLogicsCore;
   import Logics.Signals.TSignal;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Resources.Constants.CONST_COUNTER;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_ORGANIZATION;
   import Resources.Constants.CONST_SIGNAL;
   import Resources.Strings.STRING_ORGANIZATION;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowOrgDonate extends TProcessorLobbyWindow
   {
      
      protected static const KEY_COUNTER_OrgDailyDonate:Vector.<uint> = CONST_COUNTER.KEY_COUNTER_OrgDailyDonate;
      
      protected static const KEY_OrgDailyDonate:uint = CONST_COUNTER.KEY_OrgDailyDonate;
      
      protected var FMC:Sprite;
      
      protected var FTF_Exploit:TextField;
      
      protected var FTF_Money:TextField;
      
      protected var FTF_DonateMoney:TextField;
      
      protected var FTF_DonateGold:TextField;
      
      protected var FTF_Limit:TextField;
      
      protected var FBtn_DonateMoney:MovieClip;
      
      protected var FBtn_DonateGold:MovieClip;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FData_Exploit:Number;
      
      protected var FData_OrgMoney:int;
      
      protected var FData_Limit:uint;
      
      protected var FLimitMoney:uint;
      
      protected var FDonateGold:uint;
      
      protected var FDonateMoney:uint;
      
      protected var FOrgDevotionBin:TBins;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FUIWindowConfirmationCopy:TUIWindowConfirmation;
      
      protected var FSetOrgDonateStatus:Function;
      
      public function TProcessorWindowOrgDonate(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_ORGANIZATION.RESOURCESID_Swf_OrganizationMain);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC = TUtilityReflection.CreateDisplayObjectInstance(CONST_ORGANIZATION.RESOURCE_ClassName_MC_OrgDonate) as Sprite;
         addChild(this.FMC);
         this.FTF_Exploit = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_TF_Exploit];
         this.FTF_Money = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_TF_Money];
         this.FTF_DonateMoney = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_TF_DonateMoney];
         this.FTF_DonateGold = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_TF_DonateGold];
         this.FBtn_DonateMoney = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_Btn_DonateMoney];
         this.FBtn_DonateGold = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_Btn_DonateGold];
         this.FBtn_Close = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_BTN_Close];
         this.FTF_Limit = this.FMC["TF_Limit"];
         this.FTF_DonateMoney.restrict = "0-9";
         this.FTF_DonateGold.restrict = "0-9";
         this.FTF_DonateMoney.addEventListener(Event.CHANGE,this.OnChangeText_Money);
         this.FTF_DonateGold.addEventListener(Event.CHANGE,this.OnChangeText_Gold);
         TGameUtil.setButtonMode(this.FBtn_DonateMoney,true);
         TGameUtil.setButtonMode(this.FBtn_DonateGold,true);
         this.FOrgDevotionBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_OrganizationDevotion);
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         this.FUIWindowConfirmationCopy = new TUIWindowConfirmation(Parent);
         this.FUIWindowConfirmationCopy.OnOK = this.OnConfirmationOkCopy;
         this.FUIWindowConfirmationCopy.x = (FUICore.StageWidth - this.FUIWindowConfirmationCopy.WindowWidth) / 2;
         this.FUIWindowConfirmationCopy.y = (FUICore.StageHeight - this.FUIWindowConfirmationCopy.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationCopy);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_DonateMoney.addEventListener(MouseEvent.CLICK,this.OnBtnDonateMoneyClick);
         this.FBtn_DonateGold.addEventListener(MouseEvent.CLICK,this.OnBtnDonateGoldClick);
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnClose);
         this.FTF_DonateGold.addEventListener(Event.CHANGE,this.OnChangeText_Gold);
         this.FTF_DonateMoney.addEventListener(Event.CHANGE,this.OnChangeText_Money);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         this.LogicsPerform_Signals();
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TOrganizationDevotion = null;
         var _loc3_:uint = 0;
         if(this.FMC == null)
         {
            return;
         }
         _loc1_ = uint(SLogicsCore.Character.MainHero.Level);
         _loc2_ = this.FOrgDevotionBin.GetDatebaseByIdentifier(91200000 + _loc1_) as TOrganizationDevotion;
         _loc3_ = _loc2_.DevotionSivMax;
         this.FTF_Exploit.text = String(this.FData_Exploit);
         this.FTF_Money.text = String(this.FData_OrgMoney);
         this.FLimitMoney = _loc3_ - this.FData_Limit;
         if(this.FLimitMoney <= 0)
         {
            this.FLimitMoney = 0;
         }
         this.FLimitMoney = uint(this.FLimitMoney);
         this.FTF_Limit.text = String(STRING_ORGANIZATION.STRING_LimitMoneyDonate + this.FLimitMoney);
      }
      
      protected function LogicsPerform_Signals() : void
      {
         var _loc1_:TSignal = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc1_ = SLogicsCore.SignalRetrieve(CONST_SIGNAL.SIGNALDESTINATION_COUNTER_OrgDailyDonate_Ret);
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_ = _loc1_.Identifier;
         _loc3_ = uint(_loc1_.Value);
         switch(_loc2_)
         {
            case KEY_OrgDailyDonate:
               this.FData_Limit = _loc3_;
               this.UpdateUI();
               if(this.FSetOrgDonateStatus != null)
               {
                  this.FSetOrgDonateStatus(this.FData_Limit <= 0);
               }
         }
      }
      
      protected function Reset() : void
      {
         this.FTF_DonateMoney.text = "1";
         this.FTF_DonateGold.text = "1";
      }
      
      protected function ProcessorOnClose(param1:Object) : void
      {
         ProcessorWindowClose();
         this.Reset();
      }
      
      protected function OnBtnDonateMoneyClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         this.FDonateMoney = uint(this.FTF_DonateMoney.text);
         if(this.FDonateMoney * 1000 > SLogicsCore.Character.CreditSilverCoin.ToNumber())
         {
            FOnEffectText(this,STRING_ORGANIZATION.STRING_NoEnoughMoney);
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_DonateReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(this.FDonateMoney);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.OnChangeText_Money(this);
      }
      
      protected function OnBtnDonateGoldClick(param1:MouseEvent) : void
      {
         this.FDonateGold = uint(this.FTF_DonateGold.text);
         if(this.FDonateGold > SLogicsCore.Character.CreditGold)
         {
            this.FUIWindowRecharge.Visible = true;
            return;
         }
         this.FUIWindowConfirmationCopy.Text = TUtilityString.Format(new ConsumeFrame(70270078).DescribeString,this.FDonateGold);
         this.FUIWindowConfirmationCopy.Visible = true;
      }
      
      protected function OnConfirmationOkCopy(param1:Object) : void
      {
         this.C_Sc();
      }
      
      protected function C_Sc() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_DonateReq);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(this.FDonateGold);
         _loc2_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         this.OnChangeText_Gold(this);
      }
      
      protected function OnChangeText_Gold(param1:Object) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc3_ = uint(this.FTF_DonateGold.text);
         _loc2_ = uint(SLogicsCore.Character.CreditGold);
         if(_loc3_ > _loc2_)
         {
            if(_loc2_ <= 0)
            {
               this.FTF_DonateGold.text = "1";
            }
            else
            {
               this.FTF_DonateGold.text = _loc2_.toString();
            }
         }
         if(_loc3_ <= 0)
         {
            this.FTF_DonateGold.text = "1";
         }
         this.FDonateGold = uint(this.FTF_DonateGold.text);
      }
      
      protected function OnChangeText_Money(param1:Object) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = uint(this.FTF_DonateMoney.text);
         this.FTF_DonateMoney.text = _loc2_.toString();
         _loc3_ = _loc2_ * 1000;
         _loc4_ = Math.min(this.FLimitMoney,SLogicsCore.Character.CreditSilverCoin.ToNumber());
         if(_loc3_ > _loc4_)
         {
            if(_loc4_ <= 0)
            {
               this.FTF_DonateMoney.text = "1";
            }
            else
            {
               this.FTF_DonateMoney.text = String(Math.floor(_loc4_ / 1000));
            }
         }
         if(_loc3_ <= 0)
         {
            this.FTF_DonateMoney.text = "1";
         }
         if(uint(this.FTF_DonateMoney.text) <= 0)
         {
            this.FTF_DonateMoney.text = "1";
         }
         this.FDonateMoney = uint(this.FTF_DonateGold.text);
      }
      
      public function set SetOrgDonateStatus(param1:Function) : void
      {
         this.FSetOrgDonateStatus = param1;
      }
      
      public function UpData(param1:Number, param2:int) : void
      {
         this.PerformPacket_CS_UpdateCounterReq();
         this.FData_Exploit = param1;
         this.FData_OrgMoney = param2;
      }
      
      public function UpDateUI() : void
      {
         this.UpdateUI();
      }
      
      public function PerformPacket_CS_UpdateCounterReq() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<uint> = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         _loc1_ = int(KEY_COUNTER_OrgDailyDonate.length);
         _loc2_ = new Vector.<uint>(_loc1_);
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc2_[_loc4_] = KEY_COUNTER_OrgDailyDonate[_loc4_];
            SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_COUNTER_OrgDailyDonate_Req,0,0,_loc2_);
            _loc4_++;
         }
      }
   }
}

