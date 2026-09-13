package Processors.Game.Lobby.CopyClassroom
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Common.TBounds;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.CopyHero.TCopyHero;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Logics.Signals.TSignal;
   import Logics.TimeCoolDown.TTimeCoolDown;
   import Logics.Vip.TVip;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.CopyClassroom.Component.TUICopyHeroBox;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_COPYCLASSROOM;
   import Resources.Constants.CONST_COUNTER;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SIGNAL;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COPYCLASSROOM;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowCopyClassroom extends TProcessorLobbyWindow
   {
      
      protected static const BoxNum:int = 4;
      
      protected static const TabNum:int = 2;
      
      protected static const KEY_CopyNum:uint = CONST_COUNTER.KEY_CopyNum;
      
      protected static const KEY_BuyCopyNum:uint = CONST_COUNTER.KEY_BuyCopyNum;
      
      protected static const KEY_CopyEndTime:uint = CONST_COUNTER.KEY_CopyEndTime;
      
      protected static const KEY_EFL_CopyHereID:uint = CONST_COUNTER.KEY_EFL_CopyHereID;
      
      protected static const KEY_CopyHeroCardID:uint = CONST_COUNTER.KEY_CopyHeroCardID;
      
      protected static const KEY_CanCopyCount:uint = CONST_COUNTER.KEY_CanCopyCount;
      
      protected var FIndex:int;
      
      protected var FCopyHeroIndex:int;
      
      protected var FTempMc:MovieClip;
      
      protected var FMC_Main:Sprite;
      
      protected var FMC_CopyHero:Sprite;
      
      protected var FMC_CopyHeroBody:Sprite;
      
      protected var FMC_CopyHeroAllSlot:MovieClip;
      
      protected var FMC_CopyHeroSlotList:Sprite;
      
      protected var FMC_GotoSuperHero:Sprite;
      
      protected var FTF_GotoSuperHero:TextField;
      
      protected var FMC_BoxSelect:Sprite;
      
      protected var FMC_NoOpen:Sprite;
      
      protected var FTF_LimitBuyTimes:TextField;
      
      protected var FTF_FreeCopyCount:TextField;
      
      protected var FCopyClassRoomBound:TBounds;
      
      protected var FCopyHeroBoxs:Vector.<TUICopyHeroBox>;
      
      protected var FAllCopyHeros:uint;
      
      protected var FUIPage:TUIPage;
      
      protected var FPageIndex:int;
      
      protected var FSelectPageIndex:int;
      
      protected var FHint:THint;
      
      protected var FHelpHint:THint;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FCopyHeroBin:TBins;
      
      protected var FRoleModelBin:TBins;
      
      protected var FBaseHeroBin:TBins;
      
      protected var FInitialization:Boolean;
      
      protected var FInitializationSlots:Boolean;
      
      protected var FChangeTab:TUITab;
      
      protected var FCopyHeroTab:TUITab;
      
      protected var FChangeTabIndex:int;
      
      protected var FCopyHeroTabIndex:int;
      
      protected var FBtn_Buy:SimpleButton;
      
      protected var FBtn_Help:SimpleButton;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FMC_FreeTip:Sprite;
      
      protected var FCopyTimeCoolDown:TTimeCoolDown;
      
      protected var FCopyingTimeIndex:int;
      
      protected var FCopyBoxIndex:int;
      
      protected var FMC_EffectLeft:MovieClip;
      
      protected var FMC_EffectRight:MovieClip;
      
      protected var FCharacter:TCharacter;
      
      protected var FVipData:TVip;
      
      protected var FSelectedBoxIndex:int;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FHelpHintOnOver:Function;
      
      protected var FHelpHintOnOut:Function;
      
      protected var FCopyClassroomClose:Function;
      
      protected var FCopyingHeroOnClick:Function;
      
      protected var FCopyingBuyOnClick:Function;
      
      protected var FOnShortcutHyperlinks:Function;
      
      protected var FChangeCopyHero:Function;
      
      protected var FFreeTipOver:Function;
      
      protected var FFreeTipOut:Function;
      
      protected var FCopyingTimes:int;
      
      protected var FFreeChangeCopyHeroCount:int;
      
      protected var FCanCopyingCount:int;
      
      protected var FAlreadyBuyCount:uint;
      
      protected var FCopyedCardID:int;
      
      protected var FBChangedNormalBody:Boolean;
      
      protected var FBSetSelectBox:Boolean;
      
      protected var FBChangeCopyHeroData:Boolean;
      
      protected var FCardIDFromSuperHero:int;
      
      protected var FCopyHeros:Vector.<TCopyHero>;
      
      protected var FCopyHeroCardIDFromSHero:Vector.<int>;
      
      public function TProcessorWindowCopyClassroom(param1:TUIComponent)
      {
         super(param1);
         this.FCopyHeroBoxs = new Vector.<TUICopyHeroBox>(BoxNum);
         this.FUIPage = new TUIPage(this);
         this.FChangeTab = new TUITab(this);
         this.FCopyHeroTab = new TUITab(this);
         this.FCopyHeros = new Vector.<TCopyHero>();
         this.FCharacter = SLogicsCore.Character;
         this.FVipData = this.FCharacter.VipData;
         this.FCopyTimeCoolDown = new TTimeCoolDown(CONST_COMMON.TIME_COOLDOWN_CopyHero);
         SLogicsCore.Character.TimeCoolDowns.Add(this.FCopyTimeCoolDown);
         this.FSelectedBoxIndex = 0;
         this.FChangeTabIndex = 0;
         this.FCopyHeroTabIndex = 0;
         this.FCardIDFromSuperHero = 0;
         this.FBSetSelectBox = false;
         this.FInitializationSlots = false;
         this.FInitialization = false;
         this.FBChangeCopyHeroData = false;
         this.FBChangedNormalBody = true;
         this.FHint = new THint();
         this.FHelpHint = new THint();
         this.FOverlayerHint = new TOverlayerHint(this);
         this.FCopyHeroCardIDFromSHero = new Vector.<int>();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_COPYCLASSROOM.RESOURCESID_Swf_COPYCLASSROOM);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TUICopyHeroBox = null;
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         this.FMC_Main = TUtilityReflection.CreateDisplayObjectInstance(CONST_COPYCLASSROOM.RESOURCE_ClassName_MC_CopyClassroom) as Sprite;
         this.addChild(this.FMC_Main);
         this.FMC_CopyHero = this.FMC_Main[CONST_COPYCLASSROOM.RESOURCE_Link_MC_CopyHeroView];
         this.FMC_CopyHeroBody = this.FMC_CopyHero[CONST_COPYCLASSROOM.RESOURCE_Link_MC_CopyHeroViewPart];
         this.FMC_NoOpen = this.FMC_CopyHero["MC_NoOpen"];
         this.FMC_NoOpen.visible = false;
         this.FMC_CopyHeroAllSlot = this.FMC_CopyHeroBody[CONST_COPYCLASSROOM.RESOURCE_Link_MC_AllSlot];
         this.FMC_CopyHeroAllSlot.gotoAndStop(1);
         this.FMC_CopyHeroSlotList = this.FMC_CopyHeroAllSlot[CONST_COPYCLASSROOM.RESOURCE_Link_MC_SlotList];
         this.FMC_BoxSelect = this.FMC_CopyHeroSlotList[CONST_COPYCLASSROOM.RESOURCE_Link_MC_SelectBoxTip];
         this.FMC_EffectLeft = this.FMC_Main[CONST_COPYCLASSROOM.RESOURCE_Link_MC_EffectLeft];
         this.FMC_EffectRight = this.FMC_Main[CONST_COPYCLASSROOM.RESOURCE_Link_MC_EffectRight];
         this.FMC_FreeTip = this.FMC_CopyHeroBody["MC_FreeTip"];
         this.FMC_FreeTip.mouseChildren = false;
         this.FMC_FreeTip.buttonMode = true;
         this.FMC_BoxSelect.visible = false;
         this.FMC_EffectLeft.gotoAndStop(1);
         this.FMC_EffectRight.gotoAndStop(1);
         _loc1_ = 0;
         while(_loc1_ < TabNum)
         {
            _loc6_ = this.FMC_Main[CONST_COPYCLASSROOM.RESOURCE_Link_Change_Tabs + _loc1_];
            this.FChangeTab.SetTabByIndex(_loc6_,_loc1_);
            _loc1_++;
         }
         this.FChangeTab.OnSwitch = this.ChangeTabOnSwitch;
         this.FChangeTab.Init();
         this.FBtn_Buy = this.FMC_CopyHeroBody[CONST_COPYCLASSROOM.RESOURCE_Link_Btn_Buy];
         this.FBtn_Close = this.FMC_Main[CONST_COPYCLASSROOM.RESOURCE_Link_Btn_Close];
         this.FBtn_Help = this.FMC_Main[CONST_COPYCLASSROOM.RESOURCE_Link_Btn_Help];
         _loc1_ = 0;
         while(_loc1_ < BoxNum)
         {
            _loc3_ = this.FMC_CopyHeroSlotList[CONST_COPYCLASSROOM.RESOURCE_Link_MC_Card + _loc1_];
            _loc5_ = new TUICopyHeroBox(this);
            _loc5_.Perform_UIDispatch(_loc3_);
            _loc5_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc5_.BoxClick = this.OnBoxClick;
            _loc5_.Over = this.OnBoxOver;
            _loc5_.Out = this.OnBoxOut;
            _loc5_.TutorialNextStep = TutorialNextStep;
            this.FCopyHeroBoxs[_loc1_] = _loc5_;
            _loc1_++;
         }
         _loc4_ = this.FMC_CopyHeroBody[CONST_COPYCLASSROOM.RESOURCE_Link_MC_PageLeft];
         this.FUIPage.ButtonPrevious.Substrate = _loc4_;
         _loc4_ = this.FMC_CopyHeroBody[CONST_COPYCLASSROOM.RESOURCE_Link_MC_PageRight];
         this.FUIPage.ButtonNext.Substrate = _loc4_;
         this.FUIPage.PageSize = BoxNum;
         this.FUIPage.Init();
         this.FUIPage.OnChangePage = this.PageOnChange;
         this.FTF_LimitBuyTimes = this.FMC_CopyHeroBody[CONST_COPYCLASSROOM.RESOURCE_Link_TF_CanCopyTimes];
         this.FTF_FreeCopyCount = this.FMC_CopyHeroBody[CONST_COPYCLASSROOM.RESOURCE_Link_TF_FreeCopyCount];
         this.FHint = new THint();
         this.FMC_GotoSuperHero = this.FMC_CopyHeroBody[CONST_COPYCLASSROOM.RESOURCE_Link_MC_GotoSuperHero];
         this.FTF_GotoSuperHero = this.FMC_GotoSuperHero[CONST_COPYCLASSROOM.RESOURCE_Link_TF_GotoSuperHero];
         this.SetTextLink();
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.OnBtnCloseClick,false,0,true);
         this.FBtn_Buy.addEventListener(MouseEvent.CLICK,this.OnBtnCopyingBuyClick,false,0,true);
         this.FMC_FreeTip.addEventListener(MouseEvent.MOUSE_OVER,this.OnFreeTipOver,false,0,true);
         this.FMC_FreeTip.addEventListener(MouseEvent.MOUSE_OUT,this.OnFreeTipOut,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.OnHintHelpMove,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_OUT,this.OnHintHelpOut,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         super.LogicsPerform();
         if(this.FInitializationSlots)
         {
            _loc1_ = 0;
            while(_loc1_ < BoxNum)
            {
               this.FCopyHeroBoxs[_loc1_].UpDateSlot();
               _loc1_++;
            }
         }
         this.LogicsPerform_Signals();
      }
      
      protected function LogicsPerform_Signals() : void
      {
         var _loc1_:TSignal = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc1_ = SLogicsCore.SignalRetrieve(CONST_SIGNAL.SIGNALDESTINATION_COUNTER_CopyClassRoom_Ret);
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_ = _loc1_.Identifier;
         _loc3_ = uint(_loc1_.Value);
         switch(_loc2_)
         {
            case KEY_CopyNum:
               this.FFreeChangeCopyHeroCount = _loc3_;
               break;
            case KEY_BuyCopyNum:
               this.FAlreadyBuyCount = _loc3_;
               break;
            case KEY_CanCopyCount:
               this.FCanCopyingCount = _loc3_;
               this.UpdateTF();
               break;
            case KEY_CopyEndTime:
               this.FCopyTimeCoolDown.TimingTime = _loc3_;
               break;
            case KEY_EFL_CopyHereID:
               this.FCopyedCardID = _loc3_;
               this.UpDateBoxsFromRet();
               break;
            case KEY_CopyHeroCardID:
               this.FCopyedCardID = _loc3_;
               if(this.FCopyedCardID == 0)
               {
                  this.FBChangedNormalBody = true;
               }
               else
               {
                  this.FBChangedNormalBody = false;
               }
               this.UpDateBoxsFromRet();
         }
      }
      
      protected function CopyingHeroChangeBodyReq(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(param1 == 0)
         {
            this.FBChangedNormalBody = true;
            this.FChangeCopyHero(param1);
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CopyHero_CopyingHeroReq);
            _loc3_ = _loc2_.Data;
            _loc3_.writeUnsignedInt(param1);
            SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         }
      }
      
      protected function SetTextLink() : void
      {
         var _loc1_:TextField = null;
         var _loc2_:TextFormat = new TextFormat();
         this.FMC_GotoSuperHero.mouseChildren = false;
         this.FMC_GotoSuperHero.buttonMode = true;
         _loc2_.underline = true;
         this.FTF_GotoSuperHero.text = STRING_COPYCLASSROOM.FORMAT_TextLink;
         this.FTF_GotoSuperHero.setTextFormat(_loc2_);
         this.FMC_GotoSuperHero.addEventListener(MouseEvent.CLICK,this.onGotoSuperHeroClick);
      }
      
      protected function UpdateUIPage() : void
      {
         this.FUIPage.TotalQuantity = this.FCopyHeros.length as uint;
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function UpdateUICopyHeroBox(param1:Vector.<TUICopyHeroBox>, param2:Vector.<TCopyHero>) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TUICopyHeroBox = null;
         var _loc7_:int = 0;
         var _loc8_:TCopyHero = null;
         _loc5_ = this.FPageIndex;
         _loc4_ = int(param1.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc6_ = param1[_loc3_];
            _loc6_.MyContext = null;
            _loc6_.FMC.visible = false;
            _loc3_++;
         }
         _loc4_ = int(param2.length);
         if(_loc4_ <= 0)
         {
            return;
         }
         _loc7_ = _loc5_ * param1.length;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(_loc3_ + _loc7_ >= _loc4_)
            {
               break;
            }
            _loc6_ = param1[_loc3_];
            _loc8_ = param2[_loc3_ + _loc7_];
            _loc6_.MyContext = _loc8_;
            if(_loc8_.BRecruit == 1)
            {
               _loc6_.SetNormal();
            }
            else
            {
               _loc6_.SetBlack();
            }
            if(_loc8_.CardID == this.CopyedCardID)
            {
               this.FCopyBoxIndex = _loc3_;
               _loc8_.State = 1;
            }
            else
            {
               _loc8_.State = 0;
            }
            _loc6_.UpDateSlot();
            _loc6_.FMC.visible = true;
            _loc3_++;
         }
         if(this.FBChangeCopyHeroData)
         {
            if(this.FCardIDFromSuperHero > 0)
            {
               this.SetUIPageByCardID(this.FCardIDFromSuperHero);
            }
            else if(this.FMC_BoxSelect)
            {
               this.FMC_BoxSelect.visible = false;
            }
         }
         this.FInitializationSlots = true;
      }
      
      protected function SetBoxSelectState() : void
      {
         var _loc1_:Sprite = null;
         var _loc2_:int = 0;
         _loc1_ = this.FMC_CopyHeroSlotList[CONST_COPYCLASSROOM.RESOURCE_Link_MC_Card + this.FSelectedBoxIndex] as Sprite;
         this.FMC_BoxSelect.x = _loc1_.x + (_loc1_.width - this.FMC_BoxSelect.width) / 2;
         this.FMC_BoxSelect.visible = true;
      }
      
      protected function SetUIPageByCardID(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 == 0)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < this.FCopyHeros.length)
         {
            if(this.FCopyHeros[_loc2_].HeroID == param1)
            {
               _loc3_ = _loc2_;
               break;
            }
            _loc2_++;
         }
         _loc4_ = Math.floor(_loc3_ / BoxNum);
         this.FSelectedBoxIndex = int(_loc3_ % BoxNum);
         this.PageOnChange(null,_loc4_);
         this.FPageIndex = _loc4_;
         this.UpdateUIPage();
         this.SetBoxSelectState();
         this.FBSetSelectBox = true;
      }
      
      protected function UpdateTF() : void
      {
         this.FTF_LimitBuyTimes.text = String(this.FCanCopyingCount);
         this.FTF_FreeCopyCount.text = String(this.FFreeChangeCopyHeroCount);
      }
      
      protected function onGotoSuperHeroClick(param1:MouseEvent) : void
      {
         this.FCardIDFromSuperHero = 0;
         this.UpdateBoxWithoutValue();
         this.FCardIDFromSuperHero = 0;
         this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_SuperHero);
      }
      
      protected function ChangeTabOnSwitch(param1:Object) : void
      {
         this.FCardIDFromSuperHero = 0;
         var _loc2_:int = param1 as int;
         if(_loc2_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc2_;
         if(this.FChangeTabIndex == 1)
         {
            this.FMC_NoOpen.visible = true;
            this.FMC_CopyHeroBody.visible = false;
         }
         else
         {
            this.FMC_NoOpen.visible = false;
            this.FMC_CopyHeroBody.visible = true;
         }
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TCopyHero = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TCopyHero;
         _loc6_ = SResourcesCore.TexturesMiddlePic;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.HeroID);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.HeroID,CONST_MODULES.MODULE_CopyClassroom);
         }
      }
      
      protected function OnBoxClick(param1:Object, param2:TCopyHero) : void
      {
         this.FCopyingHeroOnClick(param2);
      }
      
      protected function OnBoxOver(param1:Object, param2:TCopyHero) : void
      {
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(this,param2);
         }
      }
      
      protected function OnBoxOut(param1:Object, param2:TCopyHero) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         var _loc3_:uint = 0;
         if(param1 != null)
         {
            this.FCardIDFromSuperHero = 0;
         }
         this.FMC_CopyHeroAllSlot.gotoAndPlay(1);
         if(param2 == this.FPageIndex)
         {
            return;
         }
         this.FPageIndex = param2;
         this.UpdateUICopyHeroBox(this.FCopyHeroBoxs,this.FCopyHeros);
         _loc3_ = 0;
         while(_loc3_ < BoxNum)
         {
            if(this.FCopyHeroBoxs[_loc3_].MyContext != null && this.FCopyHeroBoxs[_loc3_].MyContext.State == 1)
            {
               this.UpDateBoxsFromRet();
               break;
            }
            _loc3_++;
         }
      }
      
      protected function OnBtnCloseClick(param1:Object) : void
      {
         this.FCardIDFromSuperHero = 0;
         this.UpdateBoxWithoutValue();
         ProcessorWindowClose();
      }
      
      protected function OnBtnCopyingBuyClick(param1:Object) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(SLogicsCore.Character.VipData.ChangeBuyNum);
         if(int(this.FTF_LimitBuyTimes.text) == 0)
         {
            if(_loc2_ - this.FAlreadyBuyCount > 0)
            {
               this.FCopyingBuyOnClick(param1,this.FAlreadyBuyCount);
            }
            else
            {
               EffectGenerateText(STRING_COPYCLASSROOM.FORMAT_NoBuyCount);
            }
         }
         else
         {
            EffectGenerateText(STRING_COPYCLASSROOM.FORMAT_HadCopyingCount);
         }
      }
      
      protected function OnFreeTipOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(SLogicsCore.Character.VipData.ChangeBuyNum);
         _loc2_ = _loc3_ - this.FAlreadyBuyCount >= 0 ? int(_loc3_ - this.FAlreadyBuyCount) : 0;
         this.FHint.Caption = TUtilityString.Format(STRING_COPYCLASSROOM.FORMAT_FreeTip,_loc2_);
         if(this.FFreeTipOver != null)
         {
            this.FFreeTipOver(this,this.FHint);
         }
      }
      
      protected function OnFreeTipOut(param1:MouseEvent) : void
      {
         if(this.FFreeTipOut != null)
         {
            this.FFreeTipOut(this);
         }
      }
      
      protected function OnHintHelpMove(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(this.FHelpHintOnOver != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_COPYNINJIA) as TSystemLanguage;
            this.FHelpHint.Content = _loc2_.Desc;
            this.FHelpHintOnOver(this,this.FHelpHint);
         }
      }
      
      protected function OnHintHelpOut(param1:MouseEvent) : void
      {
         if(this.FHelpHintOnOut != null)
         {
            this.FHelpHintOnOut(this);
         }
      }
      
      public function get CopyHeroBin() : TBins
      {
         return this.FCopyHeroBin;
      }
      
      public function set CopyHeroBin(param1:TBins) : void
      {
         this.FCopyHeroBin = param1;
      }
      
      public function get RoleModelBin() : TBins
      {
         return this.FRoleModelBin;
      }
      
      public function set RoleModelBin(param1:TBins) : void
      {
         this.FRoleModelBin = param1;
      }
      
      public function get BaseHeroBin() : TBins
      {
         return this.FBaseHeroBin;
      }
      
      public function set BaseHeroBin(param1:TBins) : void
      {
         this.FBaseHeroBin = param1;
      }
      
      public function get CopyingHeroOnClick() : Function
      {
         return this.FCopyingHeroOnClick;
      }
      
      public function set CopyingHeroOnClick(param1:Function) : void
      {
         this.FCopyingHeroOnClick = param1;
      }
      
      public function get CopyingBuyOnClick() : Function
      {
         return this.FCopyingBuyOnClick;
      }
      
      public function set CopyingBuyOnClick(param1:Function) : void
      {
         this.FCopyingBuyOnClick = param1;
      }
      
      public function get CopyingTimes() : int
      {
         return this.FCopyingTimes;
      }
      
      public function set CopyingTimes(param1:int) : void
      {
         this.FCopyingTimes = param1;
      }
      
      public function get CopyingCDTime() : int
      {
         return this.FCopyTimeCoolDown.TimingTime;
      }
      
      public function set CopyingCDTime(param1:int) : void
      {
         this.FCopyTimeCoolDown.TimingTime = param1;
      }
      
      public function get CopyedCardID() : int
      {
         return this.FCopyedCardID;
      }
      
      public function set CopyedCardID(param1:int) : void
      {
         this.FCopyedCardID = param1;
      }
      
      public function get CopyHeros() : Vector.<TCopyHero>
      {
         return this.FCopyHeros;
      }
      
      public function set CopyHeros(param1:Vector.<TCopyHero>) : void
      {
         this.FCopyHeros = param1;
      }
      
      public function get ChangeCopyHero() : Function
      {
         return this.FChangeCopyHero;
      }
      
      public function set ChangeCopyHero(param1:Function) : void
      {
         this.FChangeCopyHero = param1;
      }
      
      public function get HintOnOver() : Function
      {
         return this.FHintOnOver;
      }
      
      public function set HintOnOver(param1:Function) : void
      {
         this.FHintOnOver = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function get HelpHintOnOver() : Function
      {
         return this.FHelpHintOnOver;
      }
      
      public function set HelpHintOnOver(param1:Function) : void
      {
         this.FHelpHintOnOver = param1;
      }
      
      public function get HelpHintOnOut() : Function
      {
         return this.FHelpHintOnOut;
      }
      
      public function set HelpHintOnOut(param1:Function) : void
      {
         this.FHelpHintOnOut = param1;
      }
      
      public function get OnShortcutHyperlinks() : Function
      {
         return this.FOnShortcutHyperlinks;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      public function get BChangedNormalBody() : Boolean
      {
         return this.FBChangedNormalBody;
      }
      
      public function set BChangedNormalBody(param1:Boolean) : void
      {
         this.FBChangedNormalBody = param1;
      }
      
      public function get CopyHeroCardIDFromSHero() : Vector.<int>
      {
         return this.FCopyHeroCardIDFromSHero;
      }
      
      public function set CopyHeroCardIDFromSHero(param1:Vector.<int>) : void
      {
         this.FCopyHeroCardIDFromSHero = param1;
      }
      
      public function get CardIDFromSuperHero() : int
      {
         return this.FCardIDFromSuperHero;
      }
      
      public function set CardIDFromSuperHero(param1:int) : void
      {
         this.FCardIDFromSuperHero = param1;
      }
      
      public function get BChangeCopyHeroData() : Boolean
      {
         return this.FBChangeCopyHeroData;
      }
      
      public function set BChangeCopyHeroData(param1:Boolean) : void
      {
         this.FBChangeCopyHeroData = param1;
      }
      
      public function get FreeChangeCopyHeroCount() : int
      {
         return this.FFreeChangeCopyHeroCount;
      }
      
      public function set FreeChangeCopyHeroCount(param1:int) : void
      {
         this.FFreeChangeCopyHeroCount = param1;
      }
      
      public function get CanCopyingCount() : int
      {
         return this.FCanCopyingCount;
      }
      
      public function set CanCopyingCount(param1:int) : void
      {
         this.FCanCopyingCount = param1;
      }
      
      public function get AlreadyBuyCount() : uint
      {
         return this.FAlreadyBuyCount;
      }
      
      public function set AlreadyBuyCount(param1:uint) : void
      {
         this.FAlreadyBuyCount = param1;
      }
      
      public function get FreeTipOver() : Function
      {
         return this.FFreeTipOver;
      }
      
      public function set FreeTipOver(param1:Function) : void
      {
         this.FFreeTipOver = param1;
      }
      
      public function get FreeTipOut() : Function
      {
         return this.FFreeTipOut;
      }
      
      public function set FreeTipOut(param1:Function) : void
      {
         this.FFreeTipOut = param1;
      }
      
      public function UpdateBox(param1:Vector.<TCopyHero>) : void
      {
         this.FCopyHeros = param1;
         if(!this.FInitialization)
         {
            this.FInitialization = true;
         }
         this.UpdateUIPage();
         this.UpdateUICopyHeroBox(this.FCopyHeroBoxs,param1);
      }
      
      public function UpdateBoxWithoutValue() : void
      {
         this.FBChangeCopyHeroData = true;
         this.UpdateUICopyHeroBox(this.FCopyHeroBoxs,this.CopyHeros);
      }
      
      public function UpDateTF() : void
      {
         this.UpdateTF();
      }
      
      public function UpDateCopyingHeroCoolingTime() : void
      {
         if(this.FCopyedCardID == 0 && this.FCopyTimeCoolDown.TimingTime <= 0 && !this.FBChangedNormalBody)
         {
            this.CopyingHeroChangeBodyReq(0);
         }
         if(this.FInitializationSlots)
         {
            if(this.FCopyTimeCoolDown.TimingTime <= 0)
            {
               if(this.FCopyHeroBoxs[this.FCopyBoxIndex].MyContext != null)
               {
                  this.FCopyHeroBoxs[this.FCopyBoxIndex].MyContext.State = 0;
                  this.FCopyedCardID = 0;
               }
            }
            this.FCopyHeroBoxs[this.FCopyBoxIndex].UpDateSlotTime(this.FCopyTimeCoolDown.TimingTime);
         }
      }
      
      public function UpDateBoxsFromRet() : void
      {
         if(this.FCopyTimeCoolDown.TimingTime > 0)
         {
            this.FChangeCopyHero(this.FCopyedCardID);
         }
         if(this.FCopyHeroBoxs[this.FCopyBoxIndex] == null)
         {
            return;
         }
         this.FCopyHeroBoxs[this.FCopyBoxIndex].MyContext.State = 0;
         this.FCopyHeroBoxs[this.FCopyBoxIndex].UpDateSlotTime(this.FCopyTimeCoolDown.TimingTime);
         this.UpdateUICopyHeroBox(this.FCopyHeroBoxs,this.FCopyHeros);
         this.FCopyHeroBoxs[this.FCopyBoxIndex].MyContext.State = 1;
         this.FCopyHeroBoxs[this.FCopyBoxIndex].UpDateSlotTime(this.FCopyTimeCoolDown.TimingTime);
      }
      
      public function PlayEffect() : void
      {
         this.FMC_EffectLeft.play();
         this.FMC_EffectRight.play();
      }
      
      public function Reset() : void
      {
         this.FChangeTab.Reset();
      }
   }
}

