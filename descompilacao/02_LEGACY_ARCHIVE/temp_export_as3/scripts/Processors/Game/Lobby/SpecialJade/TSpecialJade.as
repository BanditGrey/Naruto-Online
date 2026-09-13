package Processors.Game.Lobby.SpecialJade
{
   import Components.Slots.TUISlot;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TErrorCode;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.DatebaseVO.VO.TSpecialStone;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Components.TUIHero;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SPECIALJADE;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   public class TSpecialJade extends TProcessorLobbyWindows
   {
      
      protected var FIsInitialization:Boolean;
      
      protected var thisMainPanel:MovieClip;
      
      protected var btnTypeCostList:Vector.<SimpleButton> = null;
      
      protected var txtNextTitleList:Vector.<TextField> = null;
      
      protected var txtNextAttrList:Vector.<TextField> = null;
      
      protected var txtCurTitleList:Vector.<TextField> = null;
      
      protected var txtCurAttrList:Vector.<TextField> = null;
      
      protected var btnPreviewNext:MovieClip = null;
      
      protected var btnActivity:SimpleButton = null;
      
      protected var txtExp:TextField = null;
      
      protected var mcExpBar:MovieClip = null;
      
      protected var mcExpMask:MovieClip = null;
      
      protected var MC_ItemBox:MovieClip = null;
      
      protected var MC_Bmp_Icon:MovieClip = null;
      
      protected var txtItemNum:TextField = null;
      
      protected var MC_Phase_Num:MovieClip = null;
      
      protected var MC_Phase_Word:MovieClip = null;
      
      protected var MC_Level_Num:TextField = null;
      
      protected var MC_Level_Word:MovieClip = null;
      
      protected var MC_JieNum:MovieClip = null;
      
      protected var MC_End:MovieClip;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FBtn_Help:*;
      
      protected var MC_Hero:MovieClip;
      
      protected var FUIHero:TUIHero;
      
      protected var FJadeEffSpr:Sprite;
      
      protected var FJadeEffbmp:Bitmap;
      
      protected var FJadeEffectPicID:int;
      
      private var expBarWid:int = 0;
      
      private var curExp:int = 0;
      
      private var curMaxExp:int = 0;
      
      private var curLevel:int = 0;
      
      private var itemIconBmp:Bitmap = null;
      
      private var Slot:TUISlot;
      
      private var FEffectFatherSpr:Sprite;
      
      private var txtDesc:TextField;
      
      protected var FCharacter:TCharacter;
      
      public var OnUpdateJade:Function;
      
      private var curUseCout:int;
      
      private const FtipsDescIDKeys:Array = [CONST_SYSTEMLANGUAGE.ConsumerConfirm_SpecicalJade_1,CONST_SYSTEMLANGUAGE.ConsumerConfirm_SpecicalJade_2,CONST_SYSTEMLANGUAGE.ConsumerConfirm_SpecicalJade_3,CONST_SYSTEMLANGUAGE.ConsumerConfirm_SpecicalJade_4];
      
      private var FirstInit:Boolean;
      
      private var curRes:TSpecialStone;
      
      private var FIsClickPre:Boolean;
      
      public function TSpecialJade(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FIsInitialization = false;
         SetUIModuleID(CONST_MODULES.MODULE_SpeicalJade);
      }
      
      private function HeroOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:THero = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         var _loc8_:TBounds = null;
         var _loc9_:TCoordinate = null;
         var _loc10_:TRoleModel = null;
         _loc5_ = param2 as THero;
         _loc8_ = new TBounds();
         _loc9_ = new TCoordinate();
         _loc6_ = SResourcesCore.TexturesModel;
         _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc5_.Identifier) as TRoleModel;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc10_.Model);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIndex(0);
            param3.Value.Evaluate(_loc9_,_loc8_);
            this.FUIHero.X = _loc8_.X;
            this.FUIHero.Y = _loc8_.Y;
         }
         else
         {
            _loc6_.LoadSecondary(_loc10_.Model,CONST_MODULES.MODULE_Heros);
            this.FUIHero.X = 0;
            this.FUIHero.Y = 0;
         }
         if(_loc5_.Identifier != this.FCharacter.MainHero.Identifier)
         {
            if(_loc5_.ReincarnationOneOrTwo >= 1)
            {
            }
         }
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_SPECIALJADE.RESOURCESID_Swf_Friend);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.thisMainPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_SPECIALJADE.RESOURCE_ClassName_SpecialJadeMainPanel) as MovieClip;
         addChild(this.thisMainPanel);
         this.FBtn_Close = this.thisMainPanel[CONST_SPECIALJADE.RESOURCE_Link_Btn_Close];
         this.FBtn_Help = this.thisMainPanel[CONST_SPECIALJADE.RESOURCE_Link_Btn_Help];
         this.MC_JieNum = this.thisMainPanel[CONST_SPECIALJADE.RESOURCE_Link_MC_Jie_Num];
         var _loc1_:int = 0;
         this.btnTypeCostList = new Vector.<SimpleButton>();
         _loc1_ = 0;
         while(_loc1_ < CONST_SPECIALJADE.BTN_TYPE_COST_COUNT)
         {
            this.btnTypeCostList.push(this.thisMainPanel[CONST_SPECIALJADE.BTN_TYPE_COST + _loc1_] as SimpleButton);
            _loc1_++;
         }
         this.btnPreviewNext = this.thisMainPanel[CONST_SPECIALJADE.RESOURCE_Link_BTN_PreviewNext];
         TGameUtil.setButtonMode(this.btnPreviewNext,true);
         this.btnActivity = this.thisMainPanel[CONST_SPECIALJADE.RESOURCE_Link_BTN_Activity] as SimpleButton;
         var _loc2_:TextField = null;
         this.txtCurTitleList = new Vector.<TextField>();
         this.txtCurAttrList = new Vector.<TextField>();
         _loc1_ = 0;
         while(_loc1_ < CONST_SPECIALJADE.RESOURCE_Link_CURRENT_ATTR_COUNT)
         {
            _loc2_ = this.thisMainPanel[CONST_SPECIALJADE.RESOURCE_Link_TF_Cur_Title_ + _loc1_] as TextField;
            if(_loc1_ < STRING_COMMON.STRINGS_SPECIAL_JADE_ATTRS.length)
            {
               this.txtCurTitleList.push(_loc2_);
            }
            this.txtCurAttrList.push(this.thisMainPanel[CONST_SPECIALJADE.RESOURCE_Link_TF_Cur_Value_ + _loc1_] as TextField);
            _loc1_++;
         }
         this.txtNextTitleList = new Vector.<TextField>();
         this.txtNextAttrList = new Vector.<TextField>();
         _loc1_ = 0;
         while(_loc1_ < CONST_SPECIALJADE.RESOURCE_Link_NEXT_ATTR_COUNT)
         {
            _loc2_ = this.thisMainPanel[CONST_SPECIALJADE.RESOURCE_Link_TF_Next_Title_ + _loc1_] as TextField;
            if(_loc1_ < STRING_COMMON.STRINGS_SPECIAL_JADE_ATTRS.length)
            {
               this.txtNextTitleList.push(_loc2_);
            }
            this.txtNextAttrList.push(this.thisMainPanel[CONST_SPECIALJADE.RESOURCE_Link_TF_Next_Value_ + _loc1_] as TextField);
            _loc1_++;
         }
         this.txtExp = this.thisMainPanel[CONST_SPECIALJADE.RESOURCE_Link_TF_Exp] as TextField;
         this.mcExpBar = this.thisMainPanel[CONST_SPECIALJADE.RESOURCE_Link_MC_Bar] as MovieClip;
         this.expBarWid = this.mcExpBar.width;
         this.mcExpMask = this.mcExpBar[CONST_SPECIALJADE.RESOURCE_Link_MC_Mask] as MovieClip;
         this.MC_End = this.thisMainPanel["MC_End"] as MovieClip;
         this.MC_End.visible = false;
         this.MC_ItemBox = this.thisMainPanel[CONST_SPECIALJADE.RESOURCE_Link_MC_ItemBox] as MovieClip;
         this.MC_Bmp_Icon = this.MC_ItemBox[CONST_SPECIALJADE.RESOURCE_Link_MC_Bmp_Icon] as MovieClip;
         if(this.MC_Bmp_Icon.numChildren == 0)
         {
            this.MC_Bmp_Icon.addChild(this.itemIconBmp = new Bitmap());
         }
         this.itemIconBmp.bitmapData == null;
         this.txtItemNum = this.thisMainPanel[CONST_SPECIALJADE.RESOURCE_Link_TF_ItemNum] as TextField;
         this.MC_Phase_Num = this.thisMainPanel[CONST_SPECIALJADE.RESOURCE_Link_MC_Phase_Num] as MovieClip;
         this.MC_Phase_Word = this.thisMainPanel[CONST_SPECIALJADE.RESOURCE_Link_MC_Phase_Word] as MovieClip;
         this.MC_Level_Num = this.thisMainPanel[CONST_SPECIALJADE.RESOURCE_Link_MC_Level_Num] as TextField;
         this.MC_Level_Word = this.thisMainPanel[CONST_SPECIALJADE.RESOURCE_Link_MC_Level_Word] as MovieClip;
         this.txtDesc = this.thisMainPanel[CONST_SPECIALJADE.RESOURCE_Link_TF_Desc] as TextField;
         this.x = stage.stageWidth - this.width >> 1;
         this.y = stage.stageHeight - this.height >> 1;
         this.Slot = new TUISlot(this);
         this.Slot.Resource = this.MC_ItemBox;
         this.Slot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.Slot.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.Slot.OnOverlay = UIComponentsHintOnOver;
         this.Slot.OnOut = UIComponentsHintOnOut;
         this.Slot.Init();
         this.FEffectFatherSpr = new Sprite();
         this.FUIHero = new TUIHero(this);
         this.MC_Hero = this.thisMainPanel[CONST_SPECIALJADE.RESOURCE_Link_MC_HeroPosition];
         this.MC_Hero.addChild(this.FUIHero);
         this.FUIHero.OnQuerySequenceContext = this.HeroOnQuerySequenceContext;
         this.FUIHero.DefaultRole = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as Sprite;
         this.MC_Hero.addChild(this.FEffectFatherSpr);
         this.FCharacter = SLogicsCore.Character;
         this.FUIHero.Context = this.FCharacter.MainHero;
         this.FJadeEffSpr = this.thisMainPanel[CONST_SPECIALJADE.RESOURCE_LINK_MC_EffSpr];
         this.FJadeEffbmp = new Bitmap();
         this.FJadeEffSpr.addChild(this.FJadeEffbmp);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.OnWindowClose);
         this.thisMainPanel.addEventListener(MouseEvent.CLICK,this.ClickHandle);
         this.btnActivity.addEventListener(MouseEvent.CLICK,this.OnBtnActClk);
         this.btnActivity.addEventListener(MouseEvent.MOUSE_MOVE,this.OnActBtnOnOver,false,0,true);
         this.btnActivity.addEventListener(MouseEvent.MOUSE_OUT,this.OnActBtnOnOut,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < CONST_SPECIALJADE.BTN_TYPE_COST_COUNT)
         {
            this.btnTypeCostList[_loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.OnMouseOverBtn);
            this.btnTypeCostList[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.OnMouseOutBtn);
            _loc1_++;
         }
         super.ResourcesPerform_UILocations();
      }
      
      private function GetIndexOfbtnTypeCostList(param1:SimpleButton) : int
      {
         var _loc2_:int = int(this.btnTypeCostList.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1 == this.btnTypeCostList[_loc3_])
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return 0;
      }
      
      private function OnMouseOverBtn(param1:MouseEvent) : void
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         if(this.curRes == null)
         {
            return;
         }
         var _loc2_:int = this.GetIndexOfbtnTypeCostList(SimpleButton(param1.target));
         var _loc3_:int = int(this.FtipsDescIDKeys[_loc2_]);
         var _loc4_:String = TUtilityString.GetText(_loc3_);
         var _loc5_:TConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Cion_DayNum) as TConfigValue;
         var _loc6_:int = _loc5_.Value as int;
         if(_loc2_ == 0 || _loc2_ == 1)
         {
            _loc8_ = _loc2_ == 1 ? int(this.curRes.Costmoney * 50) : this.curRes.Costmoney;
            _loc9_ = _loc2_ == 1 ? int(this.curRes.NormalExp * 50) : this.curRes.NormalExp;
            _loc10_ = _loc2_ == 1 ? int(Json.decode(this.curRes.NormalType).normalType[0] * 50) : int(Json.decode(this.curRes.NormalType).normalType[0]);
            _loc4_ = TUtilityString.Format(_loc4_,_loc8_,_loc9_,_loc10_,_loc6_ - this.curUseCout);
         }
         else if(_loc2_ == 2 || _loc2_ == 3)
         {
            _loc11_ = _loc2_ == 3 ? int(this.curRes.Costgold * 50) : this.curRes.Costgold;
            _loc12_ = _loc2_ == 3 ? int(this.curRes.GoldExp * 50) : this.curRes.GoldExp;
            _loc13_ = _loc2_ == 3 ? int(Json.decode(this.curRes.GoldType).normalType[0] * 50) : int(Json.decode(this.curRes.GoldType).normalType[0]);
            _loc4_ = TUtilityString.Format(_loc4_,_loc11_,_loc12_,_loc13_);
         }
         var _loc7_:THint = new THint();
         if(UIHelpTipsHintOnOver != null)
         {
            _loc7_.Content = _loc4_;
            UIHelpTipsHintOnOver(this,_loc7_);
         }
      }
      
      private function OnMouseOutBtn(param1:MouseEvent) : void
      {
         if(UIHelpTipsHintOnOut != null)
         {
            UIHelpTipsHintOnOut(this);
         }
      }
      
      protected function OnActBtnOnOver(param1:MouseEvent) : void
      {
         var _loc2_:THint = new THint();
         if(UIHelpTipsHintOnOver != null)
         {
            _loc2_.Content = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.Qiudao_STRING_003);
            UIHelpTipsHintOnOver(this,_loc2_);
         }
      }
      
      protected function OnActBtnOnOut(param1:MouseEvent) : void
      {
         if(UIHelpTipsHintOnOut != null)
         {
            UIHelpTipsHintOnOut(this);
         }
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:THint = new THint();
         if(UIHelpTipsHintOnOver != null)
         {
            _loc2_.Content = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.HELPTIPS_70170113);
            UIHelpTipsHintOnOver(this,_loc2_);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(UIHelpTipsHintOnOut != null)
         {
            UIHelpTipsHintOnOut(this);
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.Jade_SC_Load_User_Ret,this.PerformPacket_SC_Load_User_Ret);
         FPacketRoutines.Register(CONST_NETWORK.Jade_SC_Level_Up_Ret,this.PerformPacket_SC_Level_Up_Ret);
         FPacketRoutines.Register(CONST_NETWORK.Jade_SC_Active_Ret,this.PerformPacket_SC_Active_Ret);
         super.PacketRegisterRoutines();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.PACKETID_CS_Load_User_Req();
      }
      
      override protected function LogicsPerform() : void
      {
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.FUIHero.Update();
         this.Slot.Update();
         this.updateSpeicalJade();
         super.LogicsPerform();
      }
      
      private function OnWindowClose(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function PerformPacket_SC_Load_User_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         this.curExp = _loc2_.readInt();
         this.curLevel = _loc2_.readInt();
         this.curUseCout = _loc2_.readInt();
         this.updateViewInfo();
      }
      
      protected function PerformPacket_SC_Level_Up_Ret(param1:TPacket) : void
      {
         var _loc4_:TErrorCode = null;
         var _loc5_:String = null;
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ErrorCode,_loc3_) as TErrorCode;
            if(_loc4_ != null)
            {
               _loc5_ = _loc4_.Desc;
               if(EffectGenerateText != null)
               {
                  EffectGenerateText(_loc5_);
               }
            }
            return;
         }
         this.curExp = _loc2_.readInt();
         this.curUseCout = _loc2_.readInt();
         this.updateViewInfo();
      }
      
      protected function PerformPacket_SC_Active_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            return;
         }
         this.curExp = _loc2_.readInt();
         this.curLevel = _loc2_.readInt();
         this.updateViewInfo();
         this.OnUpdateJade(this.curLevel);
      }
      
      protected function PACKETID_CS_Load_User_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.Jade_C2S_Load_User_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PACKETID_CS_Level_Up_Req(param1:int) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.Jade_C2S_Level_Up_Req);
         _loc2_.Data.writeInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PACKETID_CS_Active_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.Jade_C2S_Active_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      private function updateViewInfo() : void
      {
         var _loc1_:TBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SpeicalJade) as TBins;
         this.curRes = _loc1_.GetDatebaseByValue("Identifier",this.curLevel) as TSpecialStone;
         var _loc2_:TSpecialStone = _loc1_.GetDatebaseByValue("Identifier",this.curRes.NextId) as TSpecialStone;
         this.MC_End.visible = _loc2_ ? false : true;
         this.curMaxExp = this.curRes.NeedExp;
         this.txtExp.text = this.curExp + "/" + this.curMaxExp;
         this.mcExpMask.width = Math.max(0,this.curExp / this.curMaxExp * this.expBarWid);
         var _loc3_:int = this.curLevel / 100000 % 10;
         this.MC_JieNum.gotoAndStop(_loc3_);
         this.FJadeEffectPicID = this.GetPreLevelRestextureID();
         var _loc4_:Vector.<uint> = new Vector.<uint>();
         _loc4_.push(this.curRes.CostItemArr[0].itemid);
         var _loc5_:TInventories = new TInventories();
         var _loc6_:TUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         _loc6_.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc5_,_loc4_);
         var _loc7_:TInventory = _loc5_.GetInventoryByTempletID(this.curRes.CostItemArr[0].itemid);
         this.Slot.Context = _loc7_;
         _loc5_ = SLogicsCore.Character.Appliances as TInventories;
         this.txtItemNum.text = _loc5_.GetAllCountByTempletID(this.curRes.CostItemArr[0].itemid).toString();
         this.MC_Level_Num.text = this.curRes.Name;
         var _loc8_:int = 0;
         _loc8_ = 0;
         while(_loc8_ < CONST_SPECIALJADE.RESOURCE_Link_CURRENT_ATTR_COUNT)
         {
            this.txtCurAttrList[_loc8_].text = this.curRes.AttrList[_loc8_];
            this.txtNextAttrList[_loc8_].text = _loc2_ ? _loc2_.AttrList[_loc8_] : "";
            if(_loc8_ >= CONST_SPECIALJADE.RESOURCE_Link_CURRENT_ATTR_COUNT - 3)
            {
               this.txtCurAttrList[_loc8_].text = this.curRes.AttrList[_loc8_] / 100 + "%";
               this.txtNextAttrList[_loc8_].text = _loc2_ ? _loc2_.AttrList[_loc8_] / 100 + "%" : "";
            }
            _loc8_++;
         }
         this.updateBtnStatus();
      }
      
      private function updateSpeicalJade() : void
      {
         TGameUtil.ShowAnimationByID(TGameUtil.Type_SpecialJade,this.FJadeEffbmp,CONST_MODULES.MODULE_SpeicalJade,this.FJadeEffectPicID,0);
      }
      
      private function PreviewNextJadeEffect() : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TBins = null;
         var _loc5_:TSpecialStone = null;
         this.FIsClickPre = !this.FIsClickPre;
         var _loc1_:String = this.FIsClickPre ? TUtilityString.GetText(CONST_SYSTEMLANGUAGE.Qiudao_STRING_001) : TUtilityString.GetText(CONST_SYSTEMLANGUAGE.Qiudao_STRING_002);
         this.btnPreviewNext.txt_preview.text = _loc1_;
         if(this.curRes == null)
         {
            return;
         }
         if(this.FIsClickPre)
         {
            _loc2_ = this.curRes.Identifier / 100000 % 10;
            _loc3_ = "68" + _loc2_ + "00001";
            _loc4_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SpeicalJade) as TBins;
            _loc5_ = _loc4_.GetDatebaseByValue("Identifier",_loc3_) as TSpecialStone;
            this.FJadeEffectPicID = _loc5_ ? _loc5_.Pid : this.curRes.Pid;
         }
         else
         {
            this.FJadeEffectPicID = this.GetPreLevelRestextureID();
         }
      }
      
      private function OnBtnActClk(param1:MouseEvent) : void
      {
         this.PACKETID_CS_Active_Req();
      }
      
      protected function ClickHandle(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.FBtn_Close:
               this.visible = false;
               return;
            case this.FBtn_Help:
               return;
            case this.btnPreviewNext:
               this.PreviewNextJadeEffect();
               return;
            default:
               var _loc2_:int = 0;
               _loc2_ = 0;
               while(_loc2_ < CONST_SPECIALJADE.BTN_TYPE_COST_COUNT)
               {
                  if(param1.target == this.btnTypeCostList[_loc2_])
                  {
                     this.PACKETID_CS_Level_Up_Req(_loc2_);
                     return;
                  }
                  _loc2_++;
               }
               return;
         }
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = param2 as TInventory;
         var _loc6_:TResourceRepositoryTexture = SResourcesCore.TexturesInventory;
         var _loc7_:TTexture = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Common);
         }
      }
      
      private function updateBtnStatus() : void
      {
         if(this.curRes == null)
         {
            return;
         }
         var _loc1_:TSpecialStone = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SpeicalJade,this.curRes.NextId) as TSpecialStone;
         if(_loc1_ == null)
         {
            this.btnActivity.filters = [TGameUtil.GaryColorFilters];
            this.btnPreviewNext.filters = [TGameUtil.GaryColorFilters];
            this.btnPreviewNext.txt_preview.text = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.Qiudao_STRING_005);
            this.btnPreviewNext.mouseEnabled = false;
            return;
         }
         if(this.curRes.Star > _loc1_.Star && this.curExp >= this.curMaxExp)
         {
            this.btnActivity.filters = null;
         }
         else
         {
            this.btnActivity.filters = [TGameUtil.GaryColorFilters];
         }
      }
      
      private function GetPreLevelRestextureID() : int
      {
         var _loc1_:TSpecialStone = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SpeicalJade,this.curRes.NextId) as TSpecialStone;
         var _loc2_:* = int(this.curRes.Identifier / 100000 % 10);
         if(_loc1_)
         {
            _loc2_--;
         }
         return CONST_SPECIALJADE.RESOURCE_SpecialJade_textureIDS[_loc2_];
      }
   }
}

