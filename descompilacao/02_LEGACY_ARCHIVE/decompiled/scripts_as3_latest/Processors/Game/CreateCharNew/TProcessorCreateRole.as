package Processors.Game.CreateCharNew
{
   import Externals.SExternalCore;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityMath;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Agent.SParametersCore;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TErrorCode;
   import Logics.DatebaseVO.VO.TRandomName;
   import Logics.GeneralStar.TEsotericPoints;
   import Logics.SLogicsCore;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_ACCOUNT;
   import Resources.Constants.CONST_CHARACTER;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_LOBBY;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_PLATE;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorCreateRole extends TProcessorGame
   {
      
      protected static const GENDER_Female:uint = CONST_CHARACTER.GENDER_Female;
      
      protected static const GENDER_Male:uint = CONST_CHARACTER.GENDER_Male;
      
      protected static const STRING_VIRTUALNAMES:String = STRING_COMMON.STRING_VIRTUALNAMES;
      
      public static var Num:int = 3;
      
      public static var EffectNum:int = 6;
      
      protected var FBaseHeros:TBins;
      
      protected var MC_LandingInterface:Sprite;
      
      protected var FBtn_CreateRole:MovieClip;
      
      protected var FBtn_RandomName:SimpleButton;
      
      protected var FTF_UserName:TextField;
      
      protected var FTF_VirtualName:TextField;
      
      protected var FNinjaVec:Vector.<MovieClip>;
      
      protected var FNinjaSelectVec:Vector.<MovieClip>;
      
      protected var FEffectPlayer:Vector.<MovieClip>;
      
      protected var FManMvc:MovieClip;
      
      protected var FwomanMvc:MovieClip;
      
      protected var FInitialize:Boolean;
      
      protected var FProfession:int;
      
      protected var FGender:int;
      
      protected var FCharacter:TCharacter;
      
      protected var FEsotericPoints:TEsotericPoints;
      
      protected var FLastNames:Vector.<String>;
      
      protected var FMaleNames:Vector.<String>;
      
      protected var FMaleNames2:Vector.<String>;
      
      protected var FFemaleNames:Vector.<String>;
      
      protected var FFemaleNames2:Vector.<String>;
      
      protected var FVirtualNames:Vector.<String>;
      
      protected var FTempVirtualNamesA:Vector.<String>;
      
      protected var FEffDelayReferenceTick:int;
      
      protected var FStrDelayReferenceTick:int;
      
      protected var FStrIntervalReferenceTick:int;
      
      protected var FCurFrame:int;
      
      protected var FOnEffectText:Function;
      
      protected var FCurIndex:int;
      
      protected var FPreMvc:MovieClip = null;
      
      public function TProcessorCreateRole(param1:TUIComponent)
      {
         super(param1);
         this.FVirtualNames = new Vector.<String>();
         this.FTempVirtualNamesA = new Vector.<String>();
         this.FNinjaVec = new Vector.<MovieClip>(Num);
         this.FNinjaSelectVec = new Vector.<MovieClip>(Num);
         this.FEffectPlayer = new Vector.<MovieClip>(EffectNum);
         this.FCharacter = SLogicsCore.Character;
         this.FEsotericPoints = this.FCharacter.EsotericPoints;
         FResourcesState = RESOURCESSTATE_UIRequest;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.ResourceBin.LoadPrimary(CONST_DATEBASEVO.RESOURCEID_Base);
         SResourcesCore.TexturesSwfCommon.LoadPrimary(CONST_COMMON.RESOURCESID_Swf_Common);
         SResourcesCore.TexturesSwfCreateChar.LoadPrimary(CONST_ACCOUNT.RESOURCESID_Swf_Account);
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_SHORTCUTS.RESOURCESID_Shortcut);
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_SHORTCUTS.RESOURCESID_Activity_Shortcut);
         SResourcesCore.TexturesLobby.LoadPrimary(CONST_LOBBY.RESOURCESID_Textures_ShortcutEffect);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIWait() : void
      {
         if(!SResourcesCore.ResourceBin.Loading && !SResourcesCore.TexturesSwfCommon.Loading && !SResourcesCore.TexturesSwfCreateChar.Loading && !SResourcesCore.TexturesSwfLobby.Loading && !SResourcesCore.TexturesLobby.Loading)
         {
            FResourcesState = RESOURCESSTATE_UIDispatch;
         }
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBins = null;
         var _loc4_:TRandomName = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         this.FBaseHeros = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BaseHero);
         _loc3_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RandomName);
         _loc4_ = _loc3_.GetDatebaseByIndex(0) as TRandomName;
         _loc2_ = int(_loc4_.LastNames.length);
         this.FLastNames = new Vector.<String>(_loc2_);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FLastNames[_loc1_] = _loc4_.LastNames[_loc1_];
            _loc1_++;
         }
         _loc2_ = int(_loc4_.MaleNames.length);
         this.FMaleNames = new Vector.<String>(_loc2_);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FMaleNames[_loc1_] = _loc4_.MaleNames[_loc1_];
            _loc1_++;
         }
         _loc2_ = int(_loc4_.MaleNames2.length);
         this.FMaleNames2 = new Vector.<String>(_loc2_);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FMaleNames2[_loc1_] = _loc4_.MaleNames2[_loc1_];
            _loc1_++;
         }
         _loc2_ = int(_loc4_.FemaleNames.length);
         this.FFemaleNames = new Vector.<String>(_loc2_);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FFemaleNames[_loc1_] = _loc4_.FemaleNames[_loc1_];
            _loc1_++;
         }
         _loc2_ = int(_loc4_.FemaleNames2.length);
         this.FFemaleNames2 = new Vector.<String>(_loc2_);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FFemaleNames2[_loc1_] = _loc4_.FemaleNames2[_loc1_];
            _loc1_++;
         }
         this.MC_LandingInterface = TUtilityReflection.CreateDisplayObjectInstance(CONST_ACCOUNT.RESOURCE_ClassName_MC_Account) as Sprite;
         addChild(this.MC_LandingInterface);
         _loc1_ = 0;
         while(_loc1_ < Num)
         {
            this.FNinjaVec[_loc1_] = this.MC_LandingInterface[CONST_ACCOUNT.RESOURCE_ClassName_MC_Role_Frame + _loc1_];
            this.FNinjaVec[_loc1_].buttonMode = true;
            this.FNinjaSelectVec[_loc1_] = this.MC_LandingInterface[CONST_ACCOUNT.RESOURCE_ClassName_MC_LightSource_ + _loc1_];
            this.FNinjaSelectVec[_loc1_].mouseEnabled = false;
            this.FNinjaSelectVec[_loc1_].mouseChildren = false;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < EffectNum)
         {
            this.FEffectPlayer[_loc1_] = this.MC_LandingInterface[CONST_ACCOUNT.RESOURCE_ClassName_MC_EffectPlay_Frame + _loc1_];
            this.FEffectPlayer[_loc1_].mouseEnabled = false;
            this.FEffectPlayer[_loc1_].mouseChildren = false;
            _loc1_++;
         }
         this.FManMvc = this.MC_LandingInterface[CONST_ACCOUNT.RESOURCE_ClassName_MC_ManSelect_Btn];
         this.FManMvc.buttonMode = true;
         this.FwomanMvc = this.MC_LandingInterface[CONST_ACCOUNT.RESOURCE_ClassName_MC_WomanSelect_Btn];
         this.FwomanMvc.buttonMode = true;
         _loc8_ = CONST_ACCOUNT.RESOURCE_MC_NameBox;
         _loc9_ = CONST_ACCOUNT.RESOURCE_Link_Btn_CreateRole;
         this.FBtn_CreateRole = this.MC_LandingInterface[_loc9_];
         this.FBtn_CreateRole.buttonMode = true;
         _loc9_ = CONST_ACCOUNT.RESOURCE_Link_Btn_RandomName;
         this.FBtn_RandomName = this.MC_LandingInterface[_loc8_][_loc9_] as SimpleButton;
         _loc9_ = CONST_ACCOUNT.RESOURCE_Link_TF_UserName;
         this.FTF_UserName = this.MC_LandingInterface[_loc8_][_loc9_] as TextField;
         this.FTF_UserName.restrict = STRING_COMMON.EditorStringRestrict;
         this.FTF_UserName.maxChars = STRING_COMMON.EditorStringRestrict_MaxChars;
         this.FTF_VirtualName = this.MC_LandingInterface[CONST_ACCOUNT.RESOURCE_Link_TF_VirtualName];
         this.FTF_VirtualName.wordWrap = true;
         this.Initialization();
         this.FInitialize = true;
         _loc2_ = 60;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc10_ = this.CreatVirtualNames();
            this.FVirtualNames.push(TUtilityString.Format(STRING_VIRTUALNAMES,_loc10_));
            this.FTempVirtualNamesA.push(_loc10_);
            _loc1_++;
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.ButtonRandomNameOnClick(null);
         this.FGender = 1;
         this.FCurFrame = 1;
         this.SetMoviClipFrame(this.FManMvc,4);
         this.UpdateShow(1);
         this.NinjaOut(null);
         SExternalCore.BrazilLog(3);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CREATECHAR_CreateCharRet,this.PacketPerform_SC_CreateCharRet);
      }
      
      protected function PacketPerform_SC_CreateCharRet(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:String = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            this.EffectGenerateTextByErrorCode(_loc2_);
            this.FTF_UserName.setSelection(0,this.FTF_UserName.text.length);
            if(FUICore.UIStage.focus != this.FTF_UserName)
            {
               FUICore.UIStage.focus = this.FTF_UserName;
            }
            return;
         }
         this.Visible = false;
         _loc4_ = this.FTF_UserName.text;
         if(SParametersCore.AgentID == CONST_PLATE.ID_PLATE_NORMAL)
         {
            SExternalCore.CreateChar(_loc4_);
         }
         SExternalCore.GameRolePostLog(1);
         SExternalCore.SendUserIp();
         if(SParametersCore.AgentID == CONST_PLATE.ID_PLATE_JOYFUN || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_EUROPE || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_BRAZIL || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_FRENCH || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_DE || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_ESP || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_FB_OTHER || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_IT)
         {
            SExternalCore.JoyFunLog(1);
         }
         SExternalCore.BrazilLog(4);
      }
      
      protected function EffectGenerateTextByErrorCode(param1:uint) : void
      {
         var _loc2_:TBins = null;
         var _loc3_:TErrorCode = null;
         var _loc4_:String = null;
         _loc4_ = null;
         _loc2_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ErrorCode);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.GetDatebaseByIdentifier(param1) as TErrorCode;
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_.Desc;
            }
         }
         if(_loc4_ != null)
         {
            if(this.FOnEffectText != null)
            {
               this.FOnEffectText(this,_loc4_,null,null);
            }
         }
      }
      
      protected function CreatVirtualNames() : String
      {
         var _loc1_:uint = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         _loc2_ = this.GetRandomName(this.FLastNames);
         _loc1_ = TUtilityMath.RandomRange(0,1);
         switch(_loc1_)
         {
            case GENDER_Female:
               _loc3_ = this.GetRandomName(this.FFemaleNames) + this.GetRandomName(this.FFemaleNames2);
               break;
            case GENDER_Male:
               _loc3_ = this.GetRandomName(this.FMaleNames) + this.GetRandomName(this.FMaleNames2);
         }
         return _loc2_ + _loc3_;
      }
      
      protected function GetRandomName(param1:Vector.<String>) : String
      {
         var _loc2_:int = 0;
         _loc2_ = TUtilityMath.RandomRange(0,param1.length - 1);
         return param1[_loc2_];
      }
      
      protected function Initialization() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Sprite = null;
         _loc1_ = 0;
         while(_loc1_ < Num)
         {
            this.FNinjaVec[_loc1_].addEventListener(MouseEvent.CLICK,this.NinjaClick);
            this.FNinjaVec[_loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.NinjaOver);
            this.FNinjaVec[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.NinjaOut);
            _loc1_++;
         }
         this.FBtn_RandomName.addEventListener(MouseEvent.CLICK,this.ButtonRandomNameOnClick,false,0,true);
         this.FBtn_CreateRole.addEventListener(MouseEvent.CLICK,this.ButtonCreateRoleOnClick,false,0,true);
         this.FBtn_CreateRole.addEventListener(MouseEvent.MOUSE_DOWN,this.CreateRoleDown);
         this.FBtn_CreateRole.addEventListener(MouseEvent.MOUSE_UP,this.CreateRoleUp);
         this.FBtn_CreateRole.addEventListener(MouseEvent.MOUSE_OVER,this.CreateRoleOVER);
         this.FBtn_CreateRole.addEventListener(MouseEvent.MOUSE_OUT,this.CreateRoleOUT);
         this.FManMvc.addEventListener(MouseEvent.MOUSE_OVER,this.ManMvcOnOver);
         this.FManMvc.addEventListener(MouseEvent.MOUSE_OUT,this.ManMvcOnOut);
         this.FManMvc.addEventListener(MouseEvent.MOUSE_DOWN,this.ManMvcOnDown);
         this.FwomanMvc.addEventListener(MouseEvent.MOUSE_OVER,this.ManMvcOnOver);
         this.FwomanMvc.addEventListener(MouseEvent.MOUSE_OUT,this.ManMvcOnOut);
         this.FwomanMvc.addEventListener(MouseEvent.MOUSE_DOWN,this.womanMvcOnDown);
         this.ButtonRandomNameOnClick(null);
      }
      
      protected function ButtonRandomNameOnClick(param1:MouseEvent) : void
      {
         this.FTF_UserName.text = this.CreatVirtualNames();
      }
      
      protected function CreateRoleDown(param1:MouseEvent) : void
      {
         MovieClip(param1.currentTarget).gotoAndStop(3);
      }
      
      protected function CreateRoleUp(param1:MouseEvent) : void
      {
         MovieClip(param1.currentTarget).gotoAndStop(2);
      }
      
      protected function CreateRoleOVER(param1:MouseEvent) : void
      {
         MovieClip(param1.currentTarget).gotoAndStop(2);
      }
      
      protected function CreateRoleOUT(param1:MouseEvent) : void
      {
         MovieClip(param1.currentTarget).gotoAndStop(1);
      }
      
      protected function ButtonCreateRoleOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CREATECHAR_CreateChar);
         _loc3_ = _loc2_.Data;
         _loc4_ = this.FTF_UserName.text;
         _loc5_ = uint(this.FProfession);
         _loc7_ = this.FTempVirtualNamesA.length;
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            if(this.FTempVirtualNamesA[_loc6_] == _loc4_)
            {
               this.FOnEffectText(this,STRING_COMMON.STRING_NameRepeat,null,null);
               return;
            }
            _loc6_++;
         }
         while(_loc4_.charAt(0) == " ")
         {
            _loc4_ = _loc4_.slice(1);
            if(_loc4_.length <= 0)
            {
               this.ButtonRandomNameOnClick(null);
               return;
            }
         }
         while(_loc4_.charAt(_loc4_.length - 1) == " ")
         {
            _loc4_ = _loc4_.slice(0,_loc4_.length - 1);
            if(_loc4_.length <= 0)
            {
               this.ButtonRandomNameOnClick(null);
               return;
            }
         }
         if(_loc4_.length < STRING_COMMON.CreateChar_NameLength_Min)
         {
            if(this.FOnEffectText != null)
            {
               this.FOnEffectText(this,STRING_COMMON.CreateChar_NameShort,null,null);
            }
            return;
         }
         TUtilityString.FlushUTF(_loc3_,_loc4_);
         _loc3_.writeByte(_loc5_);
         _loc3_.writeByte(this.FGender);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      public function NinjaOver(param1:MouseEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         var _loc3_:String = _loc2_.name;
         var _loc4_:int = int(_loc3_.charAt(_loc3_.length - 1));
         if(this.FCurFrame == _loc4_)
         {
            return;
         }
         _loc5_ = 0;
         while(_loc5_ < Num)
         {
            this.FNinjaSelectVec[_loc5_].visible = false;
            _loc5_++;
         }
         this.FNinjaSelectVec[_loc4_].visible = true;
      }
      
      public function NinjaOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < Num)
         {
            this.FNinjaSelectVec[_loc2_].visible = false;
            _loc2_++;
         }
      }
      
      public function NinjaClick(param1:MouseEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         if(this.FPreMvc != null)
         {
            if(_loc2_.name == this.FPreMvc.name)
            {
               return;
            }
         }
         this.FPreMvc = _loc2_;
         this.Resetmvc();
         var _loc3_:String = this.FPreMvc.name;
         var _loc4_:int = int(_loc3_.charAt(_loc3_.length - 1));
         this.FCurFrame = _loc4_;
         switch(_loc4_)
         {
            case 0:
               this.FProfession = 3;
               break;
            case 1:
               this.FProfession = 4;
               break;
            case 2:
               this.FProfession = 1;
         }
         if(this.FGender)
         {
            _loc5_ = 0;
         }
         else
         {
            _loc5_ = 3;
         }
         this.FEffectPlayer[_loc5_ + _loc4_].gotoAndPlay(1);
         this.NinjaOut(null);
      }
      
      public function SetInitilization() : void
      {
         if(this.FGender)
         {
            this.FEffectPlayer[0 + this.FCurFrame].gotoAndPlay(1);
            this.FPreMvc = this.FNinjaVec[this.FCurFrame];
         }
         else
         {
            this.FEffectPlayer[3 + this.FCurFrame].gotoAndPlay(1);
            this.FPreMvc = this.FNinjaVec[this.FCurFrame];
         }
         switch(this.FCurFrame)
         {
            case 0:
               this.FProfession = 3;
               break;
            case 1:
               this.FProfession = 4;
               break;
            case 2:
               this.FProfession = 1;
         }
      }
      
      public function Resetmvc() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < EffectNum)
         {
            this.FEffectPlayer[_loc1_].gotoAndStop(1);
            _loc1_++;
         }
      }
      
      public function ManMvcOnOver(param1:MouseEvent) : void
      {
         this.SetMoviClipFrame(MovieClip(param1.currentTarget),2);
      }
      
      public function ManMvcOnOut(param1:MouseEvent) : void
      {
         this.SetMoviClipFrame(MovieClip(param1.currentTarget),3);
      }
      
      public function ManMvcOnDown(param1:MouseEvent) : void
      {
         this.FGender = 1;
         this.SetMoviClipFrame(MovieClip(param1.currentTarget),4);
         this.UpdateShow(1);
      }
      
      public function womanMvcOnDown(param1:MouseEvent) : void
      {
         this.FGender = 0;
         this.SetMoviClipFrame(MovieClip(param1.currentTarget),4);
         this.UpdateShow(2);
      }
      
      public function SetMoviClipFrame(param1:MovieClip, param2:int) : void
      {
         if(param1.currentFrame == 4)
         {
            return;
         }
         if(param2 == 4)
         {
            this.FwomanMvc.gotoAndStop(3);
            this.FManMvc.gotoAndStop(3);
            this.Resetmvc();
            this.SetInitilization();
         }
         param1.gotoAndStop(param2);
      }
      
      public function UpdateShow(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < Num)
         {
            this.FNinjaVec[_loc2_].gotoAndStop(param1);
            _loc2_++;
         }
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         super.LogicsPerform();
         if(!this.FInitialize)
         {
            return;
         }
         if(!Visible)
         {
            return;
         }
         this.LogicsPerform_VirtualName();
         this.LogicsPerform_UpdataAutoPoint();
      }
      
      protected function LogicsPerform_VirtualName() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         _loc1_ = STimingCore.TickCount - this.FStrDelayReferenceTick;
         if(_loc1_ < this.FStrIntervalReferenceTick)
         {
            return;
         }
         _loc4_ = "";
         this.FVirtualNames.shift();
         _loc4_ = this.CreatVirtualNames();
         this.FVirtualNames.push(TUtilityString.Format(STRING_VIRTUALNAMES,_loc4_));
         _loc4_ = "";
         _loc3_ = this.FVirtualNames.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(_loc2_ >= 6)
            {
               break;
            }
            _loc4_ += this.FVirtualNames[_loc2_];
            _loc2_++;
         }
         this.FTF_VirtualName.htmlText = _loc4_;
         this.FStrIntervalReferenceTick = TUtilityMath.RandomRange(1500,5000);
         this.FStrDelayReferenceTick = STimingCore.TickCount;
      }
      
      protected function LogicsPerform_UpdataAutoPoint() : void
      {
         var _loc1_:Number = NaN;
         if(Boolean(stage) && Boolean(this.MC_LandingInterface))
         {
            _loc1_ = stage.stageHeight;
            if(_loc1_ > CONST_COMMON.STAGE_Max_Height)
            {
               _loc1_ = CONST_COMMON.STAGE_Max_Height;
            }
            this.MC_LandingInterface[CONST_ACCOUNT.RESOURCE_MC_NameBox].y = _loc1_ - 152;
            this.MC_LandingInterface[CONST_ACCOUNT.RESOURCE_Link_Btn_CreateRole].y = _loc1_ - 96;
         }
      }
      
      public function get OnEffectText() : Function
      {
         return this.FOnEffectText;
      }
      
      public function set OnEffectText(param1:Function) : void
      {
         this.FOnEffectText = param1;
      }
   }
}

