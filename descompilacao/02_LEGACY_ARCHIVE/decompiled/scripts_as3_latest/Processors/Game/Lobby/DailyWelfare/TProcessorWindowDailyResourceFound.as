package Processors.Game.Lobby.DailyWelfare
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DailyWelfare.TDailyWelfareData;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TDailyWelfare_GetBack;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DAILYWELFARE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_DAILYWELFARE;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowDailyResourceFound extends TUIComponent
   {
      
      protected var FScene:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FGetBackSort:Object;
      
      protected var FDailyWelfareGetBackBins:TBins;
      
      protected var FDailyWelfareGetBask:TDailyWelfare_GetBack;
      
      protected var FDailyWelfareData:TDailyWelfareData;
      
      protected var FResourceFoundPrice:uint;
      
      protected var FKeySort:Array;
      
      protected var FResourceFoundItemList:Vector.<TResourceFoundItem>;
      
      protected var FModule:uint;
      
      protected var FModern:uint;
      
      protected var FOnGenerateEffectText:Function;
      
      protected var FOnEffectSign:Function;
      
      public function TProcessorWindowDailyResourceFound(param1:TUIComponent)
      {
         super(param1);
         this.FDailyWelfareData = new TDailyWelfareData();
         this.FResourceFoundItemList = new Vector.<TResourceFoundItem>();
      }
      
      protected function ResourcesPerformUIDispatch(param1:MovieClip) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TConfigValue = null;
         var _loc4_:TResourceFoundItem = null;
         var _loc5_:String = null;
         this.FScene = param1;
         addChild(this.FScene);
         TGameUtil.setButtonMode(this.FScene["Btn_OneKeyFree"],true);
         TGameUtil.setButtonMode(this.FScene["Btn_OneKeyGold"],true);
         this.FScene["Btn_OneKeyFree"].addEventListener(MouseEvent.CLICK,this.OnOneKeyFreeClick);
         this.FScene["Btn_OneKeyGold"].addEventListener(MouseEvent.CLICK,this.OnOneKeyGoldClick);
         this.FScrollBar = new TScrollBar(this.FScene["MC_List"],185,false,0);
         this.FDailyWelfareGetBackBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DailyWelfare_GetBack);
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Welfare_GetBack_Price) as TConfigValue;
         this.FResourceFoundPrice = _loc3_.Value as uint;
         if(this.FKeySort == null)
         {
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Welfare_GetBack_Sort) as TConfigValue;
            this.FGetBackSort = _loc3_.Value as Object;
            this.FKeySort = new Array();
            for(_loc5_ in this.FGetBackSort)
            {
               this.FKeySort.push([this.FGetBackSort[_loc5_],_loc5_]);
            }
            this.FKeySort.sort(this.KeySortFun);
         }
         this.ChechReward();
         _loc2_ = 0;
         while(_loc2_ < this.FKeySort.length)
         {
            _loc4_ = new TResourceFoundItem(this);
            this.FScrollBar.AddItem(_loc4_);
            _loc4_.x = 235 * (_loc2_ % 2);
            _loc4_.y = _loc4_.height * int(_loc2_ / 2);
            _loc4_.InitData(_loc2_,this.FDailyWelfareGetBask.GetDateBySortKey(this.FKeySort[_loc2_][0] - 1,TDailyWelfare_GetBack.TYPE_SILVER),this.FDailyWelfareGetBask.GetDateBySortKey(this.FKeySort[_loc2_][0] - 1,TDailyWelfare_GetBack.TYPE_EXP),this.FKeySort[_loc2_][0]);
            this.FResourceFoundItemList.push(_loc4_);
            _loc4_.OnGetReward = this.CheckMoneyEnough;
            _loc2_++;
         }
         this.FScrollBar.MaxHeight = int((this.FKeySort.length - 1) / 2 + 1) * 91;
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent.Parent);
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
      }
      
      protected function KeySortFun(param1:Array, param2:Array) : int
      {
         return param1[0] - param2[0];
      }
      
      protected function GetResourceIdByModeleId(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TConfigValue = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(this.FKeySort == null)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Welfare_GetBack_Sort) as TConfigValue;
            this.FGetBackSort = _loc4_.Value as Object;
            this.FKeySort = new Array();
            for(_loc6_ in this.FGetBackSort)
            {
               this.FKeySort.push([this.FGetBackSort[_loc6_],_loc6_]);
            }
            this.FKeySort.sort(this.KeySortFun);
         }
         _loc3_ = 0;
         _loc5_ = CONST_DAILYWELFARE.ModuleIndex[param1];
         _loc2_ = 0;
         while(_loc2_ < this.FKeySort.length)
         {
            if(this.FKeySort[_loc2_][1] == _loc5_)
            {
               _loc3_ = uint(this.FKeySort[_loc2_][0]);
               break;
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      protected function GetModeleIdByResourceId(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:Vector.<String> = null;
         _loc2_ = 0;
         while(_loc2_ < this.FKeySort.length)
         {
            if(this.FKeySort[_loc2_][0] == param1)
            {
               _loc4_ = this.FKeySort[_loc2_][1];
               break;
            }
            _loc2_++;
         }
         _loc5_ = CONST_DAILYWELFARE.ModuleIndex;
         _loc2_ = 0;
         while(_loc2_ < _loc5_.length)
         {
            if(_loc5_[_loc2_] == _loc4_)
            {
               _loc3_ = _loc2_;
               break;
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      protected function PerformPacket_DailyWelfare_RecordRet(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         _loc3_ = uint(param1.readShort());
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1.readUnsignedInt();
            _loc7_ = param1.readUnsignedInt();
            _loc8_ = param1.readUnsignedInt();
            _loc5_ = this.GetResourceIdByModeleId(_loc7_);
            this.FDailyWelfareData.SetResourceData(_loc5_,_loc4_,_loc8_);
            _loc2_++;
         }
         this.UpdateUI();
      }
      
      protected function PerformPacket_DailyWelfare_RewardRet(param1:uint) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = this.GetResourceIdByModeleId(param1);
         this.FDailyWelfareData.SetResourceData(_loc2_,0,2);
         this.UpdateUI();
      }
      
      protected function PerformPacket_DailyWelfare_GroupRewardRet() : void
      {
         this.FDailyWelfareData.SetGroupResourceData();
         this.UpdateUI();
      }
      
      protected function CheckMoneyEnough(param1:Object, param2:uint, param3:uint) : void
      {
         this.FModule = this.GetModeleIdByResourceId(param2);
         this.FModern = param3;
         if(this.FModern == 1)
         {
            this.OnGetReward(this);
         }
         else
         {
            this.FUIWindowConfirmation.Visible = true;
            this.FUIWindowConfirmation.OnOK = this.OnGetReward;
            this.FUIWindowConfirmation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_DailyWelfare_ResourceFound).DescribeString,this.FResourceFoundPrice);
         }
      }
      
      protected function OnGetReward(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DailyWelfare_DailyGetBackRewardReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeInt(this.FModule);
         _loc3_.writeInt(this.FModern);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnGetGroupReward(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.FResourceFoundPrice * this.FDailyWelfareData.GetGroupResourceFoundCount() > SLogicsCore.Character.CreditGold + SLogicsCore.Character.CreditGiftCertificate)
         {
            if(this.FOnGenerateEffectText != null)
            {
               this.FOnGenerateEffectText(this,STRING_COMMON.NOTENOUGH_Gold);
            }
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DailyWelfare_DailyGetBackGroupRewardReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TResourceFoundItem = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Boolean = false;
         _loc1_ = 0;
         while(_loc1_ < this.FResourceFoundItemList.length)
         {
            _loc2_ = this.FResourceFoundItemList[_loc1_];
            _loc3_ = this.FDailyWelfareData.GetResourceTimesById(_loc2_.IconIndex);
            _loc4_ = this.FDailyWelfareData.GetResourceStatusById(_loc2_.IconIndex);
            _loc2_.SetData(_loc3_,_loc4_);
            _loc1_++;
         }
         _loc5_ = false;
         _loc1_ = 0;
         while(_loc1_ < this.FDailyWelfareData.ResourceFoundIdCount)
         {
            _loc4_ = this.FDailyWelfareData.GetResourceStatusById(_loc1_ + 1);
            if(_loc4_ == TResourceFoundItem.STATUS_CANGet)
            {
               _loc5_ = true;
               break;
            }
            _loc1_++;
         }
         this.CheckEffectSign(_loc5_);
      }
      
      protected function CheckEffectSign(param1:Boolean) : void
      {
         if(this.FOnEffectSign != null)
         {
            this.FOnEffectSign(this,param1);
         }
      }
      
      protected function OnOneKeyFreeClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         _loc4_ = this.FDailyWelfareData.GetGroupResourceFoundCount();
         if(_loc4_ <= 0)
         {
            if(this.FOnGenerateEffectText != null)
            {
               this.FOnGenerateEffectText(this,STRING_DAILYWELFARE.STRING_NoResourceCanGet);
            }
         }
         else
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DailyWelfare_DailyGetBackGroupRewardReq);
            _loc3_ = _loc2_.Data;
            _loc3_.writeInt(1);
            SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         }
      }
      
      protected function OnOneKeyGoldClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = this.FDailyWelfareData.GetGroupResourceFoundCount();
         if(_loc2_ <= 0)
         {
            if(this.FOnGenerateEffectText != null)
            {
               this.FOnGenerateEffectText(this,STRING_DAILYWELFARE.STRING_NoResourceCanGet);
            }
         }
         else
         {
            this.FUIWindowConfirmation.Visible = true;
            this.FUIWindowConfirmation.OnOK = this.OnGetGroupReward;
            this.FUIWindowConfirmation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_DailyWelfare_ResourceFound).DescribeString,this.FResourceFoundPrice * _loc2_);
         }
      }
      
      public function set OnGenerateEffectText(param1:Function) : void
      {
         this.FOnGenerateEffectText = param1;
      }
      
      public function get OnGenerateEffectText() : Function
      {
         return this.FOnGenerateEffectText;
      }
      
      public function set OnEffectSign(param1:Function) : void
      {
         this.FOnEffectSign = param1;
      }
      
      public function get OnEffectSign() : Function
      {
         return this.FOnEffectSign;
      }
      
      public function ChechReward() : void
      {
         this.FDailyWelfareGetBask = this.FDailyWelfareGetBackBins.GetDatebaseByIdentifier(SLogicsCore.Character.GetMainLevel()) as TDailyWelfare_GetBack;
      }
      
      public function DailyWelfareUpdateUI() : void
      {
         this.UpdateUI();
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.ResourcesPerformUIDispatch(param1);
      }
      
      public function DailyGetBack_RecordRet(param1:ByteArray) : void
      {
         this.PerformPacket_DailyWelfare_RecordRet(param1);
      }
      
      public function DailyGetBack_RewardRet(param1:uint) : void
      {
         this.PerformPacket_DailyWelfare_RewardRet(param1);
      }
      
      public function DailyGetBack_GroupRewardRet() : void
      {
         this.PerformPacket_DailyWelfare_GroupRewardRet();
      }
      
      public function set DailyWelfareData(param1:TDailyWelfareData) : void
      {
         this.FDailyWelfareData = param1;
      }
   }
}

