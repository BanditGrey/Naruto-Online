package Processors.Game.Lobby.Mail
{
   import Components.ComboBox.*;
   import Components.Slots.*;
   import Foundation.Common.Integer.*;
   import Foundation.Queries.*;
   import Foundation.Queries.Textures.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Textures.*;
   import Foundation.SensitiveWord.*;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.*;
   import Logics.Mail.*;
   import Logics.Streamization.Inventories.*;
   import Processors.Game.Lobby.Common.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class TProcessorWindowMailDetail extends TProcessorLobbyWindow
   {
      
      protected static const CAPACITY_Slots:uint = 4;
      
      protected static const CAPACITY_TF:uint = 6;
      
      public static const TYPE_Inbox:uint = TMail.TYPE_Inbox;
      
      public static const TYPE_Sentbox:uint = TMail.TYPE_Sentbox;
      
      public static const UIType_WriteMail:uint = 3;
      
      public static const MailWrite_InputName:String = STRING_MAIL.MailWrite_InputName;
      
      public static const MailWrite_InputTittle:String = STRING_MAIL.MailWrite_InputTittle;
      
      public static const MailWrite_InputText:String = STRING_MAIL.MailWrite_InputText;
      
      public static const BASESINFOINDEX_CharacterNames:Vector.<String> = STRING_CHARACTER.BASESINFOINDEX_CharacterNames;
      
      protected var FMC_UIType:MovieClip;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FBtn_Help:SimpleButton;
      
      protected var FMC_List:MovieClip;
      
      protected var FMC_EffectRight:MovieClip;
      
      protected var FMC_Inbox:MovieClip;
      
      protected var FTF_NameInbox:TextField;
      
      protected var FTF_TittleInbox:TextField;
      
      protected var FTF_DetailInbox:TextField;
      
      protected var FTF_Data:TextField;
      
      protected var FBtn_Left:SimpleButton;
      
      protected var FBtn_Right:SimpleButton;
      
      protected var FBtn_DeleteInbox:MovieClip;
      
      protected var FBtn_Reply:MovieClip;
      
      protected var FBtn_ReceiveAccessory:MovieClip;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var FMC_Sentbox:MovieClip;
      
      protected var FTF_NameSentbox:TextField;
      
      protected var FTF_TittleSentbox:TextField;
      
      protected var FTF_DetailSentbox:TextField;
      
      protected var FBtn_DeleteSentbox:MovieClip;
      
      protected var FMC_WriteMail:MovieClip;
      
      protected var FTF_NameWriteMail:TextField;
      
      protected var FTF_TittleWriteMail:TextField;
      
      protected var FTF_DetailWriteMail:TextField;
      
      protected var FBtn_Send:MovieClip;
      
      protected var FBtn_Cancle:MovieClip;
      
      protected var FFriendComboBox:TComboBox;
      
      protected var FFriendList:Vector.<DisplayObject>;
      
      protected var FFriends:TFriendDigests;
      
      protected var FSortIndex:UInt64;
      
      protected var FMails:TMails;
      
      protected var FMail:TMail;
      
      protected var FPageIndex:int;
      
      protected var FUIType:int;
      
      protected var FTFRewardList:Vector.<TextField>;
      
      protected var FSendMailLimit:uint;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      protected var FOnDelete:Function;
      
      protected var FOnSendMail:Function;
      
      protected var FOnReceiveAccessory:Function;
      
      public function TProcessorWindowMailDetail(param1:TUIComponent)
      {
         super(param1);
         this.FSlotList = new Vector.<TUISlot>(CAPACITY_Slots);
         this.FFriendList = new Vector.<DisplayObject>();
         this.FFriends = SLogicsCore.Friends;
         this.FMails = SLogicsCore.Mails;
         this.FTFRewardList = new Vector.<TextField>(CAPACITY_TF);
         this.FFriendList = new Vector.<DisplayObject>();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUIType = -1;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_MAIL.RESOURCESID_SWF_MAIL);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:Sprite = null;
         _loc1_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_MAIL.RESOURCE_ClassName_MailDetail) as Sprite;
         addChild(_loc1_);
         this.FMC_UIType = _loc1_[CONST_MAIL.RESOURCE_Link_MC_UIType];
         this.FBtn_Close = _loc1_[CONST_MAIL.RESOURCE_Link_Btn_Close];
         this.FBtn_Help = _loc1_[CONST_MAIL.RESOURCE_Link_Btn_Help];
         this.FMC_EffectRight = _loc1_[CONST_MAIL.RESOURCE_Link_MC_EffectRight];
         this.ResourcesPerform_InboxUIDispatch();
         this.ResourcesPerform_SentboxUIDispatch();
         this.ResourcesPerform_WriteMailUIDispatch();
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function ResourcesPerform_InboxUIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         this.FMC_Inbox = this.FMC_UIType[CONST_MAIL.RESOURCE_Link_MC_Inbox];
         this.FTF_NameInbox = this.FMC_Inbox[CONST_MAIL.RESOURCE_Link_TF_Name];
         this.FTF_NameInbox.mouseEnabled = false;
         this.FTF_TittleInbox = this.FMC_Inbox[CONST_MAIL.RESOURCE_Link_TF_Tittle];
         this.FTF_TittleInbox.mouseEnabled = false;
         this.FTF_DetailInbox = this.FMC_Inbox[CONST_MAIL.RESOURCE_Link_TF_Detail];
         this.FTF_DetailInbox.mouseEnabled = false;
         this.FTF_Data = new TextField();
         this.FTF_Data.mouseEnabled = false;
         this.FTF_Data.textColor = this.FTF_DetailInbox.textColor;
         this.FTF_Data.autoSize = TextFieldAutoSize.RIGHT;
         this.FTF_Data.filters = this.FTF_DetailInbox.filters;
         this.FMC_Inbox.addChild(this.FTF_Data);
         this.FBtn_DeleteInbox = this.FMC_Inbox[CONST_MAIL.RESOURCE_Link_Btn_Delete];
         TGameUtil.setButtonMode(this.FBtn_DeleteInbox,true);
         this.FBtn_Reply = this.FMC_Inbox[CONST_MAIL.RESOURCE_Link_Btn_Reply];
         TGameUtil.setButtonMode(this.FBtn_Reply,true);
         this.FBtn_ReceiveAccessory = this.FMC_Inbox[CONST_MAIL.RESOURCE_Link_Btn_ReceiveAccessory];
         TGameUtil.setButtonMode(this.FBtn_ReceiveAccessory,true);
         this.FBtn_Left = this.FMC_Inbox[CONST_MAIL.RESOURCE_Link_MC_Reward][CONST_MAIL.RESOURCE_Link_Btn_Left];
         this.FBtn_Right = this.FMC_Inbox[CONST_MAIL.RESOURCE_Link_MC_Reward][CONST_MAIL.RESOURCE_Link_Btn_Right];
         _loc2_ = CAPACITY_Slots;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_Inbox[CONST_MAIL.RESOURCE_Link_MC_Reward][CONST_MAIL.RESOURCE_Link_MC_Slot + _loc1_] as Sprite;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.Tag = _loc1_;
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.OnOverlay = this.SlotsOnMove;
            _loc3_.OnOut = this.SlotsOnOut;
            _loc3_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc3_.Init();
            this.FSlotList[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc2_ = CAPACITY_TF;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FTFRewardList[_loc1_] = this.FMC_Inbox[CONST_MAIL.RESOURCE_Link_MC_Reward][CONST_MAIL.RESOURCE_Link_TF_Reward + _loc1_];
            this.FTFRewardList[_loc1_].mouseEnabled = false;
            this.FTFRewardList[_loc1_].text = "";
            _loc1_++;
         }
         this.ResourcesPerform_InboxUILocations();
      }
      
      protected function ResourcesPerform_InboxUILocations() : void
      {
         var _loc1_:TConfigValue = null;
         this.FBtn_DeleteInbox.addEventListener(MouseEvent.CLICK,this.ButtonDeleteInboxOnClick,false,0,true);
         this.FBtn_Reply.addEventListener(MouseEvent.CLICK,this.ButtonReplyOnClick,false,0,true);
         this.FBtn_ReceiveAccessory.addEventListener(MouseEvent.CLICK,this.ButtonReceiveAccessoryOnClick,false,0,true);
         this.FBtn_Left.addEventListener(MouseEvent.CLICK,this.ButtonLeftOnClick,false,0,true);
         this.FBtn_Right.addEventListener(MouseEvent.CLICK,this.ButtonRightOnClick,false,0,true);
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.MAIL_SEND_LIMIT_LEVEL) as TConfigValue;
         this.FSendMailLimit = _loc1_.Value as uint;
      }
      
      protected function ResourcesPerform_SentboxUIDispatch() : void
      {
         this.FMC_Sentbox = this.FMC_UIType[CONST_MAIL.RESOURCE_Link_MC_Sentbox];
         this.FBtn_DeleteSentbox = this.FMC_Sentbox[CONST_MAIL.RESOURCE_Link_Btn_Delete];
         TGameUtil.setButtonMode(this.FBtn_DeleteSentbox,true);
         this.FTF_NameSentbox = this.FMC_Sentbox[CONST_MAIL.RESOURCE_Link_TF_Name];
         this.FTF_NameSentbox.mouseEnabled = false;
         this.FTF_TittleSentbox = this.FMC_Sentbox[CONST_MAIL.RESOURCE_Link_TF_Tittle];
         this.FTF_TittleSentbox.mouseEnabled = false;
         this.FTF_DetailSentbox = this.FMC_Sentbox[CONST_MAIL.RESOURCE_Link_TF_Detail];
         this.FTF_DetailSentbox.mouseEnabled = false;
         this.ResourcesPerform_SentboxUILocations();
      }
      
      protected function ResourcesPerform_SentboxUILocations() : void
      {
         this.FBtn_DeleteSentbox.addEventListener(MouseEvent.CLICK,this.ButtonDeleteSentboxOnClick,false,0,true);
      }
      
      protected function ResourcesPerform_WriteMailUIDispatch() : void
      {
         this.FMC_WriteMail = this.FMC_UIType[CONST_MAIL.RESOURCE_Link_MC_WriteMail];
         this.FTF_TittleWriteMail = this.FMC_WriteMail[CONST_MAIL.RESOURCE_Link_TF_Tittle];
         this.FTF_DetailWriteMail = this.FMC_WriteMail[CONST_MAIL.RESOURCE_Link_TF_Detail];
         this.FTF_NameWriteMail = this.FMC_WriteMail[CONST_MAIL.RESOURCE_Link_MC_FriendList]["mc_bar"]["tf_curInfo"];
         this.FBtn_Send = this.FMC_WriteMail[CONST_MAIL.RESOURCE_Link_Btn_Send];
         TGameUtil.setButtonMode(this.FBtn_Send,true);
         this.FBtn_Cancle = this.FMC_WriteMail[CONST_MAIL.RESOURCE_Link_Btn_Cancel];
         TGameUtil.setButtonMode(this.FBtn_Cancle,true);
         this.InitialFriendList();
         this.FFriendComboBox = new TComboBox(this,this.FMC_WriteMail[CONST_MAIL.RESOURCE_Link_MC_FriendList],this.FFriendList,100,this.OnFriendSelect,false);
         this.FFriendComboBox.SetCurInfoInput();
         this.ResourcesPerform_WriteMailUILocations();
      }
      
      protected function ResourcesPerform_WriteMailUILocations() : void
      {
         this.FBtn_Send.addEventListener(MouseEvent.CLICK,this.ButtonSendOnClick,false,0,true);
         this.FBtn_Cancle.addEventListener(MouseEvent.CLICK,this.ButtonCloseOnClick,false,0,true);
         this.FTF_TittleWriteMail.addEventListener(FocusEvent.FOCUS_IN,this.TFOnFocusIn,false,0,true);
         this.FTF_NameWriteMail.addEventListener(FocusEvent.FOCUS_IN,this.TFOnFocusIn,false,0,true);
         this.FTF_DetailWriteMail.addEventListener(FocusEvent.FOCUS_IN,this.TFOnFocusIn,false,0,true);
         this.FTF_TittleWriteMail.addEventListener(FocusEvent.FOCUS_OUT,this.TFOnFocusOut,false,0,true);
         this.FTF_NameWriteMail.addEventListener(FocusEvent.FOCUS_OUT,this.TFOnFocusOut,false,0,true);
         this.FTF_DetailWriteMail.addEventListener(FocusEvent.FOCUS_OUT,this.TFOnFocusOut,false,0,true);
         this.FTF_DetailWriteMail.addEventListener(TextEvent.TEXT_INPUT,this.onTextInput,false,0,true);
         this.FTF_NameWriteMail.addEventListener(TextEvent.TEXT_INPUT,this.onTextInput,false,0,true);
         this.FTF_TittleWriteMail.addEventListener(TextEvent.TEXT_INPUT,this.onTextInput,false,0,true);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ButtonCloseOnClick,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.CLICK,this.ButtonHelpOnClick,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         _loc2_ = this.FSlotList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FSlotList[_loc1_];
            if(_loc3_ != null)
            {
               _loc3_.Update();
            }
            _loc1_++;
         }
         super.LogicsPerform();
      }
      
      protected function MakeComboItem(param1:String) : DisplayObject
      {
         var _loc2_:MovieClip = null;
         _loc2_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_MAIL.RESOURCE_ClassName_ComboBoxItem) as MovieClip;
         _loc2_.tf_into.text = param1;
         return _loc2_;
      }
      
      protected function OnFriendSelect(param1:Object, param2:int) : void
      {
      }
      
      protected function UpdateInboxInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TMail = null;
         var _loc4_:String = null;
         var _loc5_:Vector.<String> = null;
         _loc5_ = new Vector.<String>();
         _loc3_ = this.FMails.GetMailByTypeBySortIndex(this.FUIType,this.FSortIndex);
         this.FMail = _loc3_;
         this.FTF_NameInbox.text = TUtilityString.Format(STRING_MAIL.MailInbox_Name,_loc3_.Name);
         this.UpdatePageInfo();
         this.UpdateSlotInfo();
         _loc2_ = _loc3_.AccessoryList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc3_.AccessoryNumList[_loc1_] + BASESINFOINDEX_CharacterNames[_loc3_.AccessoryList[_loc1_]];
            _loc5_.push(_loc4_);
            _loc1_++;
         }
         _loc2_ = CAPACITY_TF;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc1_ >= _loc5_.length)
            {
               break;
            }
            this.FTFRewardList[_loc1_].text = _loc5_[_loc1_];
            _loc1_++;
         }
         if(_loc3_.Subject != "")
         {
            if(_loc3_.Name == STRING_MAIL.SystemMail_Name)
            {
               _loc4_ = _loc3_.Subject;
            }
            else
            {
               _loc4_ = SSensitiveWord.Filter(_loc3_.Subject);
            }
            this.FTF_TittleInbox.text = _loc4_;
         }
         if(_loc3_.Detail != "")
         {
            if(_loc3_.Name == STRING_MAIL.SystemMail_Name)
            {
               _loc4_ = _loc3_.Detail;
            }
            else
            {
               _loc4_ = SSensitiveWord.Filter(_loc3_.Detail);
            }
            this.FTF_DetailInbox.text = _loc4_;
         }
         this.FTF_Data.x = this.FTF_DetailInbox.x;
         this.FTF_Data.width = this.FTF_TittleInbox.width;
         this.FTF_Data.y = this.FTF_DetailInbox.y + this.FTF_DetailInbox.textHeight + (Boolean(this.FTF_DetailInbox.numLines > 1) ? 8 : 0);
         this.FTF_Data.text = TUtilityDate.FormatDateString(new Date(STimingCore.GetClientShowTime(_loc3_.CreatTime) * 1000));
      }
      
      protected function UpdateSentboxInfo() : void
      {
         var _loc1_:TMail = null;
         var _loc2_:String = null;
         _loc1_ = this.FMails.GetMailByTypeBySortIndex(this.FUIType,this.FSortIndex);
         this.FMail = _loc1_;
         this.FTF_NameSentbox.text = TUtilityString.Format(STRING_MAIL.MailSentbox_Name,_loc1_.Name);
         _loc2_ = SSensitiveWord.Filter(_loc1_.Subject);
         this.FTF_TittleSentbox.text = _loc2_;
         _loc2_ = SSensitiveWord.Filter(_loc1_.Detail);
         this.FTF_DetailSentbox.text = _loc2_;
      }
      
      protected function UpdateSlotInfo() : void
      {
         var _loc1_:TInventory = null;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         if(this.FMail.AccessoryList.length == 0 && this.FMail.AccessoryInventories.Count == 0)
         {
            this.FMC_Inbox[CONST_MAIL.RESOURCE_Link_MC_Reward].visible = false;
            this.FBtn_ReceiveAccessory.visible = false;
         }
         else
         {
            _loc4_ = CAPACITY_Slots;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               this.FSlotList[_loc3_].Context = null;
               this.FSlotList[_loc3_].Resource.visible = false;
               _loc3_++;
            }
            this.FMC_Inbox[CONST_MAIL.RESOURCE_Link_MC_Reward].visible = true;
            this.FBtn_ReceiveAccessory.visible = true;
            this.FMC_Inbox[CONST_MAIL.RESOURCE_Link_MC_Reward].visible = true;
            _loc4_ = CAPACITY_Slots;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc5_ = _loc3_ + this.FPageIndex * CAPACITY_Slots;
               if(_loc5_ >= this.FMail.AccessoryInventories.Count)
               {
                  break;
               }
               _loc1_ = this.FMail.AccessoryInventories.GetInventoryByIndex(_loc5_);
               this.FSlotList[_loc3_].Context = _loc1_;
               this.FSlotList[_loc3_].Resource.visible = true;
               _loc3_++;
            }
         }
      }
      
      protected function UpdatePageInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         _loc2_ = uint(this.FMail.AccessoryInventories.Count);
         _loc3_ = Math.ceil(_loc2_ / CAPACITY_Slots) - 1;
         this.FBtn_Left.visible = Boolean(this.FPageIndex != 0);
         this.FBtn_Right.visible = Boolean(_loc3_ > 0 && this.FPageIndex != _loc3_);
      }
      
      protected function InitialText() : void
      {
         this.FTF_NameWriteMail.text = MailWrite_InputName;
         this.FTF_TittleWriteMail.text = MailWrite_InputTittle;
         this.FTF_DetailWriteMail.text = MailWrite_InputText;
         this.InitialFriendList();
         this.FFriendComboBox.ResetList(this.FFriendList);
      }
      
      protected function InitialFriendList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<String> = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:TFriendDigests = null;
         var _loc5_:uint = 0;
         var _loc6_:TFriendDigest = null;
         _loc2_ = new Vector.<String>();
         if(this.FFriendList != null && this.FFriendList.length > 0)
         {
            while(this.FFriendList.length > 0)
            {
               this.FFriendList.pop();
            }
            this.FFriendList.length = 0;
         }
         _loc5_ = uint(this.FFriends.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc5_)
         {
            _loc6_ = this.FFriends.GetDigestByIndex(_loc1_);
            if(_loc6_.Type == 1)
            {
               _loc2_.push(_loc6_.Name);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            _loc3_ = this.MakeComboItem(_loc2_[_loc1_]);
            this.FFriendList.push(_loc3_);
            _loc1_++;
         }
      }
      
      protected function SetUITypeVisible(param1:uint) : void
      {
         switch(param1)
         {
            case 0:
               this.FMC_Inbox.visible = true;
               this.FMC_Sentbox.visible = false;
               this.FMC_WriteMail.visible = false;
               break;
            case 1:
               this.FMC_Inbox.visible = false;
               this.FMC_Sentbox.visible = true;
               this.FMC_WriteMail.visible = false;
               break;
            case 2:
               this.FMC_Inbox.visible = false;
               this.FMC_Sentbox.visible = false;
               this.FMC_WriteMail.visible = true;
         }
      }
      
      protected function Reset() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc2_ = CAPACITY_TF;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FTFRewardList[_loc1_].text = "";
            _loc1_++;
         }
         this.FPageIndex = 0;
         this.FTF_DetailInbox.text = "";
         this.FTF_DetailSentbox.text = "";
         this.FTF_DetailWriteMail.text = "";
         this.FTF_NameInbox.text = "";
         this.FTF_NameSentbox.text = "";
         this.FTF_NameWriteMail.text = "";
         this.FTF_TittleInbox.text = "";
         this.FTF_TittleSentbox.text = "";
         this.FTF_TittleWriteMail.text = "";
      }
      
      protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
         this.Reset();
      }
      
      protected function ButtonHelpOnClick(param1:MouseEvent) : void
      {
      }
      
      protected function ButtonDeleteInboxOnClick(param1:MouseEvent) : void
      {
         var _loc2_:Vector.<UInt64> = null;
         _loc2_ = new Vector.<UInt64>();
         _loc2_.push(this.FSortIndex);
         if(this.FOnDelete != null)
         {
            this.FOnDelete(this,_loc2_,TYPE_Inbox);
         }
      }
      
      protected function ButtonReplyOnClick(param1:MouseEvent) : void
      {
         this.SetUITypeVisible(2);
         this.InitialText();
         this.FFriendComboBox.SetInfo(this.FMail.Name);
      }
      
      protected function ButtonReceiveAccessoryOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TMail = null;
         var _loc3_:Vector.<UInt64> = null;
         _loc3_ = new Vector.<UInt64>();
         _loc2_ = this.FMails.GetMailByTypeBySortIndex(this.FUIType,this.FSortIndex);
         _loc3_.push(this.FSortIndex);
         if(this.FOnReceiveAccessory != null)
         {
            this.FOnReceiveAccessory(this,_loc3_);
         }
         this.ButtonCloseOnClick(null);
      }
      
      protected function ButtonLeftOnClick(param1:MouseEvent) : void
      {
         --this.FPageIndex;
         if(this.FPageIndex <= 0)
         {
            this.FPageIndex = 0;
         }
         this.UpdateSlotInfo();
         this.UpdatePageInfo();
      }
      
      protected function ButtonRightOnClick(param1:MouseEvent) : void
      {
         ++this.FPageIndex;
         this.UpdateSlotInfo();
         this.UpdatePageInfo();
      }
      
      protected function ButtonDeleteSentboxOnClick(param1:MouseEvent) : void
      {
         var _loc2_:Vector.<UInt64> = null;
         _loc2_ = new Vector.<UInt64>();
         _loc2_.push(this.FSortIndex);
         if(this.FOnDelete != null)
         {
            this.FOnDelete(this,_loc2_,TYPE_Sentbox);
         }
      }
      
      protected function ButtonSendOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TMail = null;
         var _loc3_:uint = 0;
         _loc3_ = uint(SLogicsCore.Character.GetMainLevel());
         if(_loc3_ < this.FSendMailLimit)
         {
            EffectGenerateText(TUtilityString.Format(STRING_MAIL.FORMAT_SendMailLimit,this.FSendMailLimit));
            return;
         }
         _loc2_ = SLogicsCore.PoolMail.AcquireMail();
         _loc2_.Name = this.FTF_NameWriteMail.text;
         _loc2_.Subject = this.FTF_TittleWriteMail.text;
         _loc2_.Detail = this.FTF_DetailWriteMail.text;
         if(this.FOnSendMail != null)
         {
            this.FOnSendMail(_loc2_);
         }
      }
      
      protected function TFOnFocusIn(param1:FocusEvent) : void
      {
         var _loc2_:TextField = null;
         _loc2_ = param1.target as TextField;
         if(_loc2_.text == MailWrite_InputName || _loc2_.text == MailWrite_InputTittle || _loc2_.text == MailWrite_InputText)
         {
            _loc2_.text = "";
         }
      }
      
      protected function TFOnFocusOut(param1:FocusEvent) : void
      {
         var _loc2_:TextField = null;
         _loc2_ = param1.target as TextField;
         if(_loc2_ == this.FTF_NameWriteMail)
         {
            if(_loc2_.text == "")
            {
               this.FTF_NameWriteMail.text = MailWrite_InputName;
            }
         }
         else if(_loc2_ == this.FTF_TittleWriteMail)
         {
            if(_loc2_.text == "")
            {
               this.FTF_TittleWriteMail.text = MailWrite_InputTittle;
            }
         }
         else if(_loc2_ == this.FTF_DetailWriteMail)
         {
            if(_loc2_.text == "")
            {
               this.FTF_DetailWriteMail.text = MailWrite_InputText;
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Mail);
         }
      }
      
      protected function SlotsOnMove(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOver != null)
         {
            this.FOnInventoryOver(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOut != null)
         {
            this.FOnInventoryOut(this,param2);
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
      
      protected function onTextInput(param1:TextEvent) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeMultiByte(param1.currentTarget.text,"");
         _loc2_.writeMultiByte(param1.text,"");
         _loc3_ = _loc2_.length;
         switch(param1.currentTarget.name)
         {
            case "tf_curInfo":
               _loc4_ = STRING_MAIL.LimitLength_CurInfo;
               break;
            case "TF_Tittle":
               _loc4_ = STRING_MAIL.LimitLength_Title;
               break;
            case "TF_Detail":
               _loc4_ = STRING_MAIL.LimitLength_Detail;
         }
         if(_loc3_ > _loc4_)
         {
            param1.preventDefault();
         }
      }
      
      public function get OnInventoryOver() : Function
      {
         return this.FOnInventoryOver;
      }
      
      public function set OnInventoryOver(param1:Function) : void
      {
         this.FOnInventoryOver = param1;
      }
      
      public function get OnInventoryOut() : Function
      {
         return this.FOnInventoryOut;
      }
      
      public function set OnInventoryOut(param1:Function) : void
      {
         this.FOnInventoryOut = param1;
      }
      
      public function get OnDelete() : Function
      {
         return this.FOnDelete;
      }
      
      public function set OnDelete(param1:Function) : void
      {
         this.FOnDelete = param1;
      }
      
      public function get OnSendMail() : Function
      {
         return this.FOnSendMail;
      }
      
      public function set OnSendMail(param1:Function) : void
      {
         this.FOnSendMail = param1;
      }
      
      public function get OnReceiveAccessory() : Function
      {
         return this.FOnReceiveAccessory;
      }
      
      public function set OnReceiveAccessory(param1:Function) : void
      {
         this.FOnReceiveAccessory = param1;
      }
      
      public function UIUpdate(param1:int, param2:UInt64) : void
      {
         this.FUIType = param1 + 1;
         this.FSortIndex = param2;
         this.Reset();
         switch(param1)
         {
            case 0:
               this.SetUITypeVisible(0);
               this.UpdateInboxInfo();
               break;
            case 1:
               this.SetUITypeVisible(1);
               this.UpdateSentboxInfo();
               break;
            default:
               this.SetUITypeVisible(2);
               this.InitialText();
         }
      }
      
      public function Update() : void
      {
         this.ButtonCloseOnClick(null);
      }
      
      public function OpenWriteMail(param1:TDigest) : void
      {
         this.FTF_NameWriteMail.text = param1.Name;
      }
      
      public function CloseComboBox() : void
      {
         this.FFriendComboBox.HideComboBoxList();
      }
      
      public function PlayEffect() : void
      {
         if(this.FMC_EffectRight.currentFrame != this.FMC_EffectRight.totalFrames)
         {
            this.FMC_EffectRight.play();
         }
      }
   }
}

