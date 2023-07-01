"""
pythonedaartifacteventinfrastructuregittagging/pythonedaartifacteventgittaggingdbus/dbus_tag_credentials_provided.py

This file defines the DbusTagCredentialsProvided class.

Copyright (C) 2023-today rydnr's pythoneda-artifact-event-infrastructure/git-tagging

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
"""

from dbus_next.service import ServiceInterface, method, signal
from dbus_next import Variant

class DbusTagCredentialsProvided(ServiceInterface):
    """
    D-Bus interface for TagCredentialsProvided

    Class name: DbusTagCredentialsProvided

    Responsibilities:
        - Define the d-bus interface for the TagCredentialsProvided event.

    Collaborators:
        - None
    """
    def __init__(self):
        """
        Creates a new DbusTagCredentialsProvided.
        """
        super().__init__('pythonedaartifactgittagging.TagCredentialsProvided')

    @signal()
    def TagCredentialsProvided(self, message: 's'):
        """
        Defines the TagCredentialsProvided d-bus signal.
        :param message: A message.
        :type message: str
        """
        pass

    @classmethod
    def path(cls) -> str:
        """
        Retrieves the d-bus path.
        :return: Such value.
        :rtype: str
        """
        return "/pythoneda/artifact/git_tagging"
