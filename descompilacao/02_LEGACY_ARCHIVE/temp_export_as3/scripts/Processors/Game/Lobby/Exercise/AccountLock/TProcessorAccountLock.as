package Processors.Game.Lobby.Exercise.AccountLock
{
   import Foundation.Network.TPacket;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorAccountLock extends TProcessorBaseActivity
   {
      
      protected static const STATUS_NONE:int = 0;
      
      protected static const STATUS_LOCK:int = 1;
      
      protected static const STATUS_UNLOCK_IP:int = 2;
      
      protected static const STATUS_UNLOCK_PASSWORD:int = 3;
      
      protected static const STATUS_CLOSE_ACCOUNTLOCK:int = 4;
      
      protected static const STR_1:int = 70420036;
      
      protected static const STR_2:int = 70420037;
      
      protected static const STR_3:int = 70420038;
      
      protected static const CONFIRM:String = "BTN_Confirm";
      
      protected static const SHOW_UNLOCK:String = "BTN_ShowUnlock";
      
      protected static const SHOW_COMMON_IP:String = "BTN_ShowIP";
      
      protected static const SHOW_EDIT:String = "BTN_ShowEdit";
      
      protected static const SHOW_OPEN:String = "BTN_ShowOpen";
      
      protected static const SHOW_CLOSE:String = "BTN_ShowClose";
      
      protected static const UNLOCK:String = "BTN_Unlock";
      
      protected static const HIDE_UNLOCK:String = "BTN_HideUnlock";
      
      protected static const COMMON_IP:String = "BTN_SetIP";
      
      protected static const HIDE_COMMON_IP:String = "BTN_HideIP";
      
      protected static const EDIT:String = "BTN_Edit";
      
      protected static const HIDE_EDIT:String = "BTN_HideEdit";
      
      protected static const OPEN_CLOSE:String = "BTN_OpenClose";
      
      protected static const PASSWORD_MIN:int = 6;
      
      protected static const PASSWORD_MAX:int = 12;
      
      protected static const REQ_UNLOCK:int = 1;
      
      protected static const REQ_SET_PASSWORD:int = 2;
      
      protected static const REQ_SET_IP:int = 3;
      
      protected static const REQ_OPEN_CLOSE:int = 4;
      
      protected var FAccountStatus:int;
      
      protected var FCommonIP:String;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FTF_Password0:TextField;
      
      protected var FTF_Password1:TextField;
      
      protected var FTF_Password2:TextField;
      
      protected var FTF_Password3:TextField;
      
      protected var FTF_Password4:TextField;
      
      protected var FTF_Password5:TextField;
      
      protected var FTF_Password6:TextField;
      
      protected var FType:int;
      
      public function TProcessorAccountLock(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         FMC_Scene.MC_Unlock.visible = false;
         FMC_Scene.MC_CommonIP.visible = false;
         FMC_Scene.MC_Edit.visible = false;
         this.FTF_Password0 = FMC_Scene.MC_Main0.TF_Password0;
         this.FTF_Password0.restrict = "a-zA-Z0-9";
         this.FTF_Password0.maxChars = PASSWORD_MAX;
         this.FTF_Password0.addEventListener(Event.CHANGE,this.OnTextInput,false,0,true);
         this.FTF_Password1 = FMC_Scene.MC_Main0.TF_Password1;
         this.FTF_Password1.restrict = "a-zA-Z0-9";
         this.FTF_Password1.maxChars = PASSWORD_MAX;
         this.FTF_Password1.addEventListener(Event.CHANGE,this.OnTextInput,false,0,true);
         TGameUtil.setButtonMode(FMC_Scene.MC_Main0.BTN_Confirm,true);
         FMC_Scene.MC_Main0.BTN_Confirm.addEventListener(MouseEvent.CLICK,this.ProcessorOnHandleClick);
         FMC_Scene.MC_Main0.btn_close.addEventListener(MouseEvent.CLICK,this.ProcessorCloseWindow);
         TGameUtil.setButtonMode(FMC_Scene.MC_Main1.BTN_ShowUnlock,true);
         FMC_Scene.MC_Main1.BTN_ShowUnlock.addEventListener(MouseEvent.CLICK,this.ProcessorOnHandleClick);
         TGameUtil.setButtonMode(FMC_Scene.MC_Main1.BTN_ShowIP,true);
         FMC_Scene.MC_Main1.BTN_ShowIP.addEventListener(MouseEvent.CLICK,this.ProcessorOnHandleClick);
         TGameUtil.setButtonMode(FMC_Scene.MC_Main1.BTN_ShowEdit,true);
         FMC_Scene.MC_Main1.BTN_ShowEdit.addEventListener(MouseEvent.CLICK,this.ProcessorOnHandleClick);
         TGameUtil.setButtonMode(FMC_Scene.MC_Main1.BTN_ShowOpen,true);
         FMC_Scene.MC_Main1.BTN_ShowOpen.addEventListener(MouseEvent.CLICK,this.ProcessorOnHandleClick);
         TGameUtil.setButtonMode(FMC_Scene.MC_Main1.BTN_ShowClose,true);
         FMC_Scene.MC_Main1.BTN_ShowClose.addEventListener(MouseEvent.CLICK,this.ProcessorOnHandleClick);
         FMC_Scene.MC_Main1.btn_close.addEventListener(MouseEvent.CLICK,this.ProcessorCloseWindow);
         this.FTF_Password2 = FMC_Scene.MC_Unlock.TF_Password;
         this.FTF_Password2.restrict = "a-zA-Z0-9";
         this.FTF_Password2.maxChars = PASSWORD_MAX;
         this.FTF_Password2.addEventListener(Event.CHANGE,this.OnTextInput,false,0,true);
         TGameUtil.setButtonMode(FMC_Scene.MC_Unlock.BTN_Unlock,true);
         FMC_Scene.MC_Unlock.BTN_Unlock.addEventListener(MouseEvent.CLICK,this.ProcessorOnHandleClick);
         FMC_Scene.MC_Unlock.BTN_HideUnlock.addEventListener(MouseEvent.CLICK,this.HideUnlock);
         this.FTF_Password3 = FMC_Scene.MC_CommonIP.MC_Password.TF_Password3;
         this.FTF_Password3.restrict = "a-zA-Z0-9";
         this.FTF_Password3.maxChars = PASSWORD_MAX;
         this.FTF_Password3.addEventListener(Event.CHANGE,this.OnTextInput,false,0,true);
         TGameUtil.setButtonMode(FMC_Scene.MC_CommonIP.BTN_SetIP,true);
         FMC_Scene.MC_CommonIP.BTN_SetIP.addEventListener(MouseEvent.CLICK,this.ProcessorOnHandleClick);
         FMC_Scene.MC_CommonIP.BTN_HideIP.addEventListener(MouseEvent.CLICK,this.HideIP);
         this.FTF_Password4 = FMC_Scene.MC_Edit.TF_Password4;
         this.FTF_Password4.restrict = "a-zA-Z0-9";
         this.FTF_Password4.maxChars = PASSWORD_MAX;
         this.FTF_Password4.addEventListener(Event.CHANGE,this.OnTextInput,false,0,true);
         this.FTF_Password5 = FMC_Scene.MC_Edit.TF_Password5;
         this.FTF_Password5.restrict = "a-zA-Z0-9";
         this.FTF_Password5.maxChars = PASSWORD_MAX;
         this.FTF_Password5.addEventListener(Event.CHANGE,this.OnTextInput,false,0,true);
         TGameUtil.setButtonMode(FMC_Scene.MC_Edit.BTN_Edit,true);
         FMC_Scene.MC_Edit.BTN_Edit.addEventListener(MouseEvent.CLICK,this.ProcessorOnHandleClick);
         FMC_Scene.MC_Edit.BTN_HideEdit.addEventListener(MouseEvent.CLICK,this.HideEdit);
         this.FTF_Password6 = FMC_Scene.MC_OpenClose.TF_Password6;
         this.FTF_Password6.restrict = "a-zA-Z0-9";
         this.FTF_Password6.maxChars = PASSWORD_MAX;
         this.FTF_Password6.addEventListener(Event.CHANGE,this.OnTextInput,false,0,true);
         TGameUtil.setButtonMode(FMC_Scene.MC_OpenClose.BTN_OpenClose,true);
         FMC_Scene.MC_OpenClose.BTN_OpenClose.addEventListener(MouseEvent.CLICK,this.ProcessorOnHandleClick);
         FMC_Scene.MC_OpenClose.BTN_HideOpenClose.addEventListener(MouseEvent.CLICK,this.HideOpenClose);
      }
      
      override protected function UpdateUI() : void
      {
         if(this.FAccountStatus == STATUS_NONE)
         {
            FMC_Scene.MC_Main0.visible = true;
            FMC_Scene.MC_Main1.visible = false;
            this.FTF_Password0.text = "";
            this.FTF_Password1.text = "";
            TGameUtil.setButtonMode(FMC_Scene.MC_Main0.BTN_Confirm,false);
         }
         else
         {
            FMC_Scene.MC_Main0.visible = false;
            FMC_Scene.MC_Main1.visible = true;
            FMC_Scene.MC_Unlock.visible = false;
            FMC_Scene.MC_CommonIP.visible = false;
            FMC_Scene.MC_Edit.visible = false;
            FMC_Scene.MC_OpenClose.visible = false;
            this.FTF_Password2.text = "";
            this.FTF_Password3.text = "";
            this.FTF_Password4.text = "";
            this.FTF_Password5.text = "";
            this.FTF_Password6.text = "";
            TGameUtil.setButtonMode(FMC_Scene.MC_Unlock.BTN_Unlock,false);
            TGameUtil.setButtonMode(FMC_Scene.MC_CommonIP.BTN_SetIP,false);
            TGameUtil.setButtonMode(FMC_Scene.MC_Edit.BTN_Edit,false);
            TGameUtil.setButtonMode(FMC_Scene.MC_OpenClose.BTN_OpenClose,false);
            if(this.FAccountStatus == STATUS_CLOSE_ACCOUNTLOCK)
            {
               FMC_Scene.MC_Main1.MC_Status.gotoAndStop(4);
               FMC_Scene.MC_Main1.BTN_ShowOpen.visible = true;
               FMC_Scene.MC_Main1.BTN_ShowClose.visible = false;
               TGameUtil.setButtonMode(FMC_Scene.MC_Main1.BTN_ShowUnlock,false);
               TGameUtil.setButtonMode(FMC_Scene.MC_Main1.BTN_ShowIP,false);
               TGameUtil.setButtonMode(FMC_Scene.MC_Main1.BTN_ShowEdit,false);
            }
            else if(this.FAccountStatus == STATUS_LOCK)
            {
               FMC_Scene.MC_Main1.MC_Status.gotoAndStop(1);
               FMC_Scene.MC_Main1.BTN_ShowOpen.visible = false;
               FMC_Scene.MC_Main1.BTN_ShowClose.visible = true;
               TGameUtil.setButtonMode(FMC_Scene.MC_Main1.BTN_ShowUnlock,true);
               TGameUtil.setButtonMode(FMC_Scene.MC_Main1.BTN_ShowIP,false);
               TGameUtil.setButtonMode(FMC_Scene.MC_Main1.BTN_ShowEdit,false);
            }
            else
            {
               if(this.FAccountStatus == STATUS_UNLOCK_IP)
               {
                  FMC_Scene.MC_Main1.MC_Status.gotoAndStop(3);
               }
               else if(this.FAccountStatus == STATUS_UNLOCK_PASSWORD)
               {
                  FMC_Scene.MC_Main1.MC_Status.gotoAndStop(2);
               }
               FMC_Scene.MC_Main1.BTN_ShowOpen.visible = false;
               FMC_Scene.MC_Main1.BTN_ShowClose.visible = true;
               TGameUtil.setButtonMode(FMC_Scene.MC_Main1.BTN_ShowUnlock,false);
               TGameUtil.setButtonMode(FMC_Scene.MC_Main1.BTN_ShowIP,true);
               TGameUtil.setButtonMode(FMC_Scene.MC_Main1.BTN_ShowEdit,true);
            }
         }
      }
      
      protected function ResetText() : void
      {
         this.FTF_Password2.text = "";
         this.FTF_Password3.text = "";
         this.FTF_Password4.text = "";
         this.FTF_Password5.text = "";
         this.FTF_Password6.text = "";
      }
      
      protected function ProcessorOnHandleClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         switch(param1.currentTarget.name)
         {
            case CONFIRM:
               if(this.FTF_Password0.text == this.FTF_Password1.text)
               {
                  this.ProcessorOnGetBoxUp(REQ_SET_PASSWORD,0,this.FTF_Password0.text);
               }
               else
               {
                  _loc2_ = new ConsumeFrameCopy(STR_2).DescribeString;
                  ProcessorEffectText(_loc2_);
               }
               break;
            case SHOW_UNLOCK:
               FMC_Scene.MC_Unlock.visible = true;
               this.ResetText();
               break;
            case SHOW_COMMON_IP:
               FMC_Scene.MC_CommonIP.visible = true;
               this.ResetText();
               if(this.FCommonIP == null || this.FCommonIP == "")
               {
                  FMC_Scene.MC_CommonIP.MC_IPStatus.gotoAndStop(2);
               }
               else
               {
                  FMC_Scene.MC_CommonIP.MC_IPStatus.gotoAndStop(1);
                  FMC_Scene.MC_CommonIP.MC_IPStatus.TF_Text.text = this.FCommonIP;
               }
               break;
            case SHOW_EDIT:
               FMC_Scene.MC_Edit.visible = true;
               this.ResetText();
               break;
            case SHOW_OPEN:
            case SHOW_CLOSE:
               FMC_Scene.MC_OpenClose.visible = true;
               if(this.FAccountStatus == STATUS_CLOSE_ACCOUNTLOCK)
               {
                  FMC_Scene.MC_OpenClose.MC_Status.gotoAndStop(2);
               }
               else
               {
                  FMC_Scene.MC_OpenClose.MC_Status.gotoAndStop(1);
               }
               this.ResetText();
               break;
            case UNLOCK:
               this.ProcessorOnGetBoxUp(REQ_UNLOCK,0,this.FTF_Password2.text);
               break;
            case COMMON_IP:
               this.ProcessorOnGetBoxUp(REQ_SET_IP,0,this.FTF_Password3.text);
               break;
            case EDIT:
               if(this.FTF_Password4.text == this.FTF_Password5.text)
               {
                  this.ProcessorOnGetBoxUp(REQ_SET_PASSWORD,0,this.FTF_Password4.text);
               }
               else
               {
                  _loc2_ = new ConsumeFrameCopy(STR_2).DescribeString;
                  ProcessorEffectText(_loc2_);
               }
               break;
            case OPEN_CLOSE:
               this.ProcessorOnGetBoxUp(REQ_OPEN_CLOSE,0,this.FTF_Password6.text);
         }
      }
      
      protected function ProcessorCloseWindow(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function HideUnlock(param1:MouseEvent) : void
      {
         FMC_Scene.MC_Unlock.visible = false;
      }
      
      protected function HideIP(param1:MouseEvent) : void
      {
         FMC_Scene.MC_CommonIP.visible = false;
      }
      
      protected function HideEdit(param1:MouseEvent) : void
      {
         FMC_Scene.MC_Edit.visible = false;
      }
      
      protected function HideOpenClose(param1:MouseEvent = null) : void
      {
         FMC_Scene.MC_OpenClose.visible = false;
      }
      
      protected function OnTextInput(param1:Event) : void
      {
         switch(param1.currentTarget.name)
         {
            case "TF_Password":
               if(this.FTF_Password2.length >= PASSWORD_MIN)
               {
                  TGameUtil.setButtonMode(FMC_Scene.MC_Unlock.BTN_Unlock,true);
               }
               else
               {
                  TGameUtil.setButtonMode(FMC_Scene.MC_Unlock.BTN_Unlock,false);
               }
               break;
            case "TF_Password3":
               if(this.FTF_Password3.length >= PASSWORD_MIN)
               {
                  TGameUtil.setButtonMode(FMC_Scene.MC_CommonIP.BTN_SetIP,true);
               }
               else
               {
                  TGameUtil.setButtonMode(FMC_Scene.MC_CommonIP.BTN_SetIP,false);
               }
               break;
            case "TF_Password4":
            case "TF_Password5":
               if(this.FTF_Password4.length >= PASSWORD_MIN && this.FTF_Password5.length >= PASSWORD_MIN)
               {
                  TGameUtil.setButtonMode(FMC_Scene.MC_Edit.BTN_Edit,true);
               }
               else
               {
                  TGameUtil.setButtonMode(FMC_Scene.MC_Edit.BTN_Edit,false);
               }
               break;
            case "TF_Password6":
               if(this.FTF_Password6.length >= PASSWORD_MIN)
               {
                  TGameUtil.setButtonMode(FMC_Scene.MC_OpenClose.BTN_OpenClose,true);
               }
               else
               {
                  TGameUtil.setButtonMode(FMC_Scene.MC_OpenClose.BTN_OpenClose,false);
               }
               break;
            default:
               if(this.FTF_Password0.length >= PASSWORD_MIN && this.FTF_Password1.length >= PASSWORD_MIN)
               {
                  TGameUtil.setButtonMode(FMC_Scene.MC_Main0.BTN_Confirm,true);
               }
               else
               {
                  TGameUtil.setButtonMode(FMC_Scene.MC_Main0.BTN_Confirm,false);
               }
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int = 0, param3:String = "") : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:int = 0;
         var _loc6_:Vector.<int> = null;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         _loc6_ = new Vector.<int>();
         if(param2 != 0)
         {
            _loc6_.push(param2);
         }
         PerformPacket_CS_AllReq(param1,_loc6_,param3);
      }
      
      protected function ProcessorOnCloseWindow() : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
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
         this.FIsOpen = true;
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.visible = false;
         this.FIsOpen = false;
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FAccountStatus = _loc2_.readUnsignedInt();
         this.FCommonIP = TUtilityString.FetchUTF(_loc2_);
         if(FIsResourcesLoadCompleted && this.visible)
         {
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
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:uint = 0;
         var _loc16_:Vector.<uint> = null;
         var _loc17_:Vector.<uint> = null;
         var _loc18_:String = null;
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc7_)
         {
            case REQ_SET_PASSWORD:
               _loc4_ = new ConsumeFrameCopy(STR_1).DescribeString;
               ProcessorEffectText(_loc4_);
               this.FAccountStatus = _loc2_.readUnsignedInt();
               this.UpdateUI();
               break;
            case REQ_UNLOCK:
               _loc4_ = new ConsumeFrameCopy(STR_3).DescribeString;
               ProcessorEffectText(_loc4_);
               this.FAccountStatus = _loc2_.readUnsignedInt();
               this.UpdateUI();
               break;
            case REQ_SET_IP:
               _loc4_ = new ConsumeFrameCopy(STR_1).DescribeString;
               ProcessorEffectText(_loc4_);
               this.FAccountStatus = _loc2_.readUnsignedInt();
               this.FCommonIP = TUtilityString.FetchUTF(_loc2_);
               this.UpdateUI();
               break;
            case REQ_OPEN_CLOSE:
               _loc4_ = new ConsumeFrameCopy(STR_1).DescribeString;
               ProcessorEffectText(_loc4_);
               this.FAccountStatus = _loc2_.readUnsignedInt();
               this.HideOpenClose(null);
               this.UpdateUI();
         }
      }
      
      public function Test() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(0);
         TUtilityString.FlushUTF(_loc3_,"172.24.16.72");
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

